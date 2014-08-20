require_relative 'lib/thorium/version'

Gem::Specification.new do |s|
  s.name           = 'thorium'
  s.version        = Thorium::VERSION
  s.date           = '2014-08-20'
  s.summary        = "Ruby gem for workflow automation"
  s.description    = "Simple workflow automation toolkit."
  s.authors        = ["Daniel Stankevich"]
  s.email          = 'standeo@gmail.com'
  s.files          = Dir['lib/**/*.rb']
  s.bindir         = 'bin'
  s.homepage       = 'http://rubygems.org/gems/thorium'
  s.license        = 'GPL3'
  s.add_runtime_dependency 'thor', '~> 0'
  s.executables << 'thorium'
end