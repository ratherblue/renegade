# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'renegade/version'

Gem::Specification.new do |spec|
  spec.name          = 'renegade'
  spec.version       = Renegade::VERSION
  spec.authors       = ['ratherblue']
  spec.email         = ['ratherblue@gmail.com']

  spec.summary       = 'Gem summary'
  spec.description   = 'Gem description'
  spec.homepage      = 'https://github.com/ratherblue/renegade'
  spec.license       = 'Apache 2.0'

  spec.files         = Dir['lib/**/*']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency('rake', '~> 10.0')
  spec.add_development_dependency('minitest')
  spec.add_development_dependency('minitest-reporters', '~> 1.1.7')
  spec.add_development_dependency('rubocop', '~> 0.37.2')
  spec.add_development_dependency('scss_lint', '~> 0.47.0')
  spec.add_development_dependency('highline', '~> 1.7.8')
end
