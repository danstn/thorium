Gem::Specification.new do |s|
  s.name           = 'thorium'
  s.version        = '0.2.2'
  s.date           = '2014-08-20'
  s.summary        = "thorium!"
  s.description    = "Workflow automation gem"
  s.authors        = ["Daniel Stankevich"]
  s.email          = 'standeo@gmail.com'
  s.files          = ["lib/thorium.rb"]
  s.homepage       = 'http://rubygems.org/gems/thorium'
  s.license        = 'GPL3'
  s.add_runtime_dependency 'thor', '~> 0'
  s.executables << 'thorium'
end