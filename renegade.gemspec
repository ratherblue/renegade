Gem::Specification.new do |s|
  s.name = 'renegade'
  s.version = '0.0.0'
  s.summary = 'Gem summary'
  s.description = 'Gem description'
  s.authors = ['Rather Blue']
  s.email = 'ratherblue@gmail.com'
  s.require_paths = ['lib']
  s.files = Dir['lib/**/*']
  s.homepage = 'http://github.com/ratherblue/renegade'
  s.license = 'Apache 2.0'

  s.add_dependency('octokit', '~> 4.2')
end
