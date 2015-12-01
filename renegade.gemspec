# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{renegade}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rather Blue"]
  s.default_executable = %q{renegade}
  s.email = %q{ratherblue@gmail.com}
  s.executables = ["renegade"]
  s.extra_rdoc_files = ["README.md"]
  s.files = Dir["lib/**/*"]
  s.homepage = %q{http://github.com/ratherblue/renegade}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.license = "Apache 2.0"
  s.summary = "summary"
  s.description = "Ruby Githooks"

  s.add_dependency("octokit", "~> 4.2.0")

  if s.respond_to? :specification_version then
    s.specification_version = 3
  end
end
