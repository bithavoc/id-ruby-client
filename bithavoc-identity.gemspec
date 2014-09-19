# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bithavoc/identity/version'

Gem::Specification.new do |spec|
  spec.name          = "bithavoc-identity"
  spec.version       = Bithavoc::Identity::VERSION
  spec.authors       = ["bithavoc"]
  spec.email         = ["im@bithavoc.io"]
  spec.summary       = "Client for Bithavoc Identity Hub"
  spec.description   = "Full-featured client library for id.bithavoc.io"
  spec.homepage      = "http://bithavoc.io/id-ruby-client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency "httparty", "~> 0.13.1"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.4.1"
  spec.add_development_dependency "webmock", "~> 1.18.0"
end
