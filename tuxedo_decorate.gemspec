# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tuxedo/version'

Gem::Specification.new do |gem|
  gem.name          = 'tuxedo_decorate'
  gem.version       = Tuxedo::VERSION
  gem.authors       = ['Jan Stevens', 'Maarten Claes']
  gem.email         = ['jan@playpass.be', 'mcls@playpass.be']

  gem.summary       = 'Tuxedo simple presenter logic under 150 LOC'
  gem.homepage      = 'https://github.com/playpasshq/tuxedo'
  gem.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if gem.respond_to?(:metadata)
    gem.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    fail 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  gem.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|gem|features)/}) }
  gem.test_files    = gem.files.grep(%r{^(test|gem|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'activesupport', '>= 4.0.0'
  gem.add_dependency 'railties', '>= 4.0.0'
  gem.add_dependency 'charlatan', '~> 0.1.0'
end
