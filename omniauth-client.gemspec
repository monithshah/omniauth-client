# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'omniauth/client/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-client"
  spec.version       = Omniauth::Client::VERSION
  spec.authors       = ["Shireesh Jayashetty"]
  spec.email         = ["oss@elitmus.com"]
  spec.summary       = 'Generic Client OAuth2 Strategy for OmniAuth'
  spec.homepage      = "https://github.com/client/omniauth-client"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'omniauth-oauth2', '~> 1.4'

  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'mocha', '~>1.0'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'simplecov'
end
