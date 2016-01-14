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

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    fail 'RubyGems 2.0 or newer is required to protect against '\
    'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject { |f|
    f.match(%r{^(test|spec|features)/})
  }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency('rake', '~> 10.0')
  spec.add_development_dependency('minitest')
  spec.add_development_dependency('rubocop', '~> 0.35.1')
  spec.add_development_dependency('coveralls')
end
