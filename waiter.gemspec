# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'waiter/version'

Gem::Specification.new do |spec|
  spec.name          = "waiter"
  spec.version       = Waiter::VERSION
  spec.authors       = ["Alexander Rjazantsev"]
  spec.email         = ["shurik.v.r@gmail.com"]

  spec.summary       = %q{Simplest delayed loader possible}
  spec.homepage      = "https://gitlab.anahoret.com/anadea/waiter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
