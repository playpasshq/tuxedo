# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
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

  gem.metadata['allowed_push_host'] = 'https://rubygems.pkg.github.com/playpasshq'
  gem.metadata['rubygems_mfa_required'] = 'true'
  gem.metadata['github_repo'] = 'ssh://github.com/playpasshq/tuxedo'

  gem.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|gem|features)/})
  end
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 3.2.0'

  gem.add_dependency 'activesupport', '>= 6.1.0'
  gem.add_dependency 'charlatan', '~> 0.1.0'
  gem.add_dependency 'dry-configurable'
  gem.add_dependency 'railties', '>= 6.1.0'
end
