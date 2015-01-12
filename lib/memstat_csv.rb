require 'memstat_csv/version'
require 'memstat'
require 'fileutils'
require 'csv'

module MemstatCSV

  class Logger < Thread

    def initialize(options={})
      prepare(options)
      super do
        monitor
      end
    end

    private

    def monitor
      @csv=CSV.open(@path, 'wb')
      @csv.sync=true
      @csv << headers
      while true
        @memstat=Memstat::Proc::Status.new(pid: Process.pid)
        @csv << [(Time.now - @start_time).round(3)] + stats
        sleep @sleep_time
      end
    end

    def prepare(options={})
      @sleep_time = options[:sleep_time] || 1
      basedir = File.expand_path(options[:basedir] || Dir.tmpdir)
      FileUtils.mkdir_p(basedir) unless File.directory?(basedir)
      @path = File.join(basedir, "memlog-#{Process.pid}.csv")
      @start_time=Time.now
    end

    def headers
      ['time (s)'] +
        Memstat::Proc::Status::FIELDS +
        Memstat::Proc::Status::FIELDS.map{|f| "#{f} (MB)"}
    end

    def stats
      Memstat::Proc::Status::FIELDS.map{ |f|
        @memstat.send(f)
      } + Memstat::Proc::Status::FIELDS.map{ |f|
        @memstat.send(f) / 1024**2
      }
    end

  end

end
