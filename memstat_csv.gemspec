# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'memstat_csv/version'

Gem::Specification.new do |spec|
  spec.name          = "memstat_csv"
  spec.version       = MemstatCsv::VERSION
  spec.authors       = ["Jef Mathiot"]
  spec.email         = ["jeff.mathiot@gmail.com"]
  spec.summary       = %q{Log memory statistics to a CSV file.}
  spec.description   = %q{Start a thread to log memory statistics to a CSV file. Based on memstat.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'mocha', '~> 1.1', '>= 1.1.0'
  spec.add_development_dependency 'minitest', '~> 5.4', '>= 5.4.1'

  spec.add_dependency "memstat", "~> 0.1.0", ">= 0.1.3"
end
