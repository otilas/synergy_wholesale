# coding: utf-8
require File.expand_path('../lib/synergy_wholesale/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = 'synergy_wholesale'
  spec.version       = SynergyWholesale::VERSION
  spec.authors       = ['Rob Jacoby']
  spec.email         = ['rob@robjacoby.com.au']
  spec.summary       = 'A wrapper around the synergy wholesale reseller API'
  spec.homepage      = 'https://github.com/robjacoby/synergy_wholesale'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0") - ['bin/console']
  spec.executables   = []
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'savon', '~> 2.11.0'
  spec.add_runtime_dependency 'dry-validation', '~> 0.10.3'
  spec.add_runtime_dependency 'dry-struct', '~> 0.1.1'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
