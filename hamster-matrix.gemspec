# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hamster/version'

Gem::Specification.new do |spec|
  spec.name          = "hamster-matrix"
  spec.version       = Hamster::Matrix::VERSION
  spec.authors       = ["Brad Urani"]
  spec.email         = ["bradurani@gmail.com"]

  spec.summary       = "Immutable Persistent Matrix using Hamster"
  spec.description   = "Immutable Persistent Matrix using Hamster that aims to copy as much of the API from Ruby's native Matrix class as possible"
  spec.homepage      = "https://github.com/bradurani/hamster-matrix."
  spec.licenses      = "public domain"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 3.0', '>= 3.0.0'

  spec.add_runtime_dependency 'hamster', '~> 1.0', '>= 1.0.0'
end
