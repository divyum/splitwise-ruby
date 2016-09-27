# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'splitwise/version'

Gem::Specification.new do |spec|
  spec.name          = "splitwise"
  spec.version       = Splitwise::VERSION
  spec.date          = '2016-09-28'
  spec.authors       = ["Divyum Rastogi"]
  spec.email         = ["divyumrastogi@gmail.com"]
  spec.summary       = "Ruby gem for using Splitwise API"
  spec.description   = "Ruby wrapper around Splitwise API. Refer http://dev.splitwise.com/ for more information."
  spec.homepage      = "https://rubygems.org/gems/splitwise"
  spec.license       = "MIT"
  spec.files         = Dir.glob('lib/**/*.rb')
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
