# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pricefinder/version'

Gem::Specification.new do |spec|
  spec.name          = "pricefinder"
  spec.version       = Pricefinder::VERSION
  spec.authors       = ["Realhub Systems"]
  spec.email         = ["ken@realhub.com.au"]

  spec.summary       = 'Thin ruby bindings for the APM Pricefinder API'
  spec.description   = 'Pricefinder API provides access to property, sale and listing searches as well as suburb statistics and SSO to the Pricefinder website capabilities.'
  spec.homepage      = "https://github.com/realhub/pricefinder-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "byebug", "~> 9.0"
  spec.add_development_dependency "rake", "~> 11.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "webmock", "~> 3.0"
  spec.add_development_dependency "vcr", "~> 3.0"
  spec.add_development_dependency "rb-readline", "~> 0"

  spec.add_dependency "faraday", "~> 0.12"
  spec.add_dependency "faraday_middleware", "~> 0"
  spec.add_dependency "json", "~> 2.1"
end
