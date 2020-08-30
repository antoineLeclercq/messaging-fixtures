# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-messaging-fixtures'
  s.summary = 'TestBench fixtures for the Messaging library'
  s.version = '1.1.2.3'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/messaging-fixtures'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3.3'

  s.add_runtime_dependency 'evt-entity_store'
  s.add_runtime_dependency 'evt-schema-fixtures'

  s.add_development_dependency 'test_bench'
end
