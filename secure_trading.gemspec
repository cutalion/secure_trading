# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'secure_trading/version'

Gem::Specification.new do |spec|
  spec.name          = "secure_trading"
  spec.version       = SecureTrading::VERSION
  spec.authors       = ["Alexander Glushkov"]
  spec.email         = ["cutalion@gmail.com"]
  spec.summary       = %q{A gem to work with SecureTrading API}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.6.6.2"
  spec.add_dependency "httpclient", "~> 2.5.1"
  spec.add_dependency "virtus", "~> 1.0.2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'minitest', "~> 5.6.0"
  spec.add_development_dependency 'guard', "~> 2.12.5"
  spec.add_development_dependency 'guard-minitest', "~> 2.4.4"
  spec.add_development_dependency 'dotenv', "~> 0.11.1"
end
