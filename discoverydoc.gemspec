Gem::Specification.new do |s|
  s.name = 'discoverydoc'
  s.version = '0.1.0'
  s.summary = 'Generates Markdown documentation from YAML discovery file.'
  s.author = 'Kai INUI'
  s.email = 'lied.der.optik@gmail.com'
  s.homepage = 'https://github.com/kaiinui/discoverydoc'
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.license  = 'MIT'
  s.executables << 'discoverydoc'

  s.add_development_dependency 'rspec'
end
