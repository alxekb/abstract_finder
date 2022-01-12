Gem::Specification.new do |s|
  s.name = 'abstract_finder'
  s.version     = '0.0.4'
  s.summary     = 'Abstract finder for rails api with gueries, sort, filter and pagination'
  s.description = 'Gem to simplify AR queries, it executes query and includes relations.'
  s.authors     = ['Aleksei Ivanov']
  s.email       = 'alx.ekb@gmail.com'
  s.files = Dir.glob('lib/**/*') + Dir.glob('bin/**/*') + %w[README.md LICENSE]
  s.require_paths = ['lib']
  s.homepage = 'https://github.com/alxekb/abstract_finder'
  s.license = 'MIT'
  s.add_dependency 'kaminari'
end
