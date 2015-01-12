require 'spec_helper'
require 'csv'

describe MemstatCSV::Logger do

  it 'logs memory statistics' do
    logger = MemstatCSV::Logger.new(basedir: './tmp', sleep_time: 0.1)
    # Yes, I know...
    sleep 1
    Thread.kill(logger)
    csv = CSV.read(File.expand_path("./tmp/memlog-#{Process.pid}.csv"))
    csv.size.must_be :>=, 2
    # Remove headers row and check its contents
    csv.shift.must_equal [
      "time (s)",
      "peak",
      "size",
      "lck",
      "pin",
      "hwm",
      "rss",
      "data",
      "stk",
      "exe",
      "lib",
      "pte",
      "swap",
      "peak (MB)",
      "size (MB)",
      "lck (MB)",
      "pin (MB)",
      "hwm (MB)",
      "rss (MB)",
      "data (MB)",
      "stk (MB)",
      "exe (MB)",
      "lib (MB)",
      "pte (MB)",
      "swap (MB)"
    ]
    # Verify content of each remaining row
    csv.each do |row|
      row.shift.must_match /^\d(\.\d{0,3})?$/
      row.each do |cell|
        cell.to_i.must_be :>=, 0
        cell.to_i.to_s.must_equal cell
      end
    end

  end

end
