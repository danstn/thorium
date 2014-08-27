require_relative 'lib/thorium/version'

Gem::Specification.new do |spec|
  spec.name           = 'thorium'
  spec.version        = Thorium::VERSION
  spec.date           = Date.today.to_s
  spec.summary        = 'Ruby gem for workflow automation'
  spec.description    = 'Simple workflow automation toolkit.'
  spec.authors        = ['Daniel Stankevich']
  spec.email          = 'standeo@gmail.com'
  spec.files          = Dir['lib/**/*.rb']
  spec.bindir         = 'bin'
  spec.homepage       = 'http://rubygems.org/gems/thorium'
  spec.license        = 'GPL3'
  spec.required_ruby_version = '>= 2.0.0'

  spec.add_runtime_dependency 'thor', '>= 0.19'
  spec.add_development_dependency 'rake', '>= 10.0'
  spec.add_development_dependency 'rspec', '>= 3.0'

  spec.executables << 'thorium'
end
