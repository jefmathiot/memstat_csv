# MemstatCsv

memstat_csv starts a thread which logs to a CSV file the memory usage for
debugging or visualization. It is based on the
[memstat](https://github.com/kenn/memstat) gem and uses the information
provided by `/proc/PID/status` :

* peak: Peak memory size
* size: Virtual memory size
* lck: Lock memory size
* hwm: "High water mark" (peak resident set size)
* rss: Resident set size
* data, stk, exe: Size of the data, stack and text segments
* lib: Shared library code size
* pte: Page table entries size

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'memstat_csv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install memstat_csv

## Usage

```ruby
# Start collecting data
mem_logger=MemstatCSV::Logger.new
# ...
# Stop collecting data
Thread.kill(mem_logger)
```

By default, the data is collected approximately every second and data is written
in a CSV file named 'memlog-PID.csv' in the system temp directory (e.g.
  `/tmp/`). If you need to override these default settings, use the `sleep_time`
and `basedir` options:

```ruby
mem_logger=MemstatCSV::Logger.new(sleep_time: 0.5, basedir: '.')
# ...
Thread.kill(mem_logger)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/memstat_csv/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
