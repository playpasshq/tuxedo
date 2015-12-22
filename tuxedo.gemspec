# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tuxedo/version'

Gem::Specification.new do |spec|
  spec.name          = "tuxedo"
  spec.version       = Tuxedo::VERSION
  spec.authors       = ["Jan Stevens"]
  spec.email         = ["jan@playpass.be"]

  spec.summary       = %q{Tuxedo simple presenter logic under 150 LOC}
  spec.homepage      = "https://github.com/playpasshq/tuxedo"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "appraisal"
  spec.add_development_dependency "rspec"

  spec.add_dependency 'activesupport', '>= 4.0.0'
  spec.add_dependency 'railties', '>= 4.0.0'
  spec.add_dependency 'charlatan'
end
