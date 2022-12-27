# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tuxedo/version'

Gem::Specification.new do |gem|
  gem.name = 'tuxedo_decorate'
  gem.version = Tuxedo::VERSION
  gem.authors = ['Jan Stevens', 'Maarten Claes']
  gem.email = ['jan@playpass.be', 'mcls@playpass.be']

  gem.summary = 'Tuxedo simple presenter logic under 150 LOC'
  gem.homepage = 'https://github.com/playpasshq/tuxedo'
  gem.license = 'MIT'

  gem.metadata['allowed_push_host'] = 'https://rubygems.org'

  gem.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|gem|features)/})
  end
  gem.test_files = gem.files.grep(%r{^(test|gem|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'activesupport', '>= 6.1.0'
  gem.add_dependency 'railties', '>= 6.1.0'
  gem.add_dependency 'charlatan', '~> 0.1.0'
end
