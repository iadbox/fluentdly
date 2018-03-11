# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fluentdly/version'

Gem::Specification.new do |spec|
  spec.name          = "fluentdly"
  spec.version       = Fluentdly::VERSION
  spec.authors       = ["Diego Lendoiro"]
  spec.email         = ["diego@iadbox.com"]

  spec.summary       = %q{Sends logs to fluentd agent}
  spec.description   = %q{Allows to customize messages for sending logs to fluentd}
  spec.homepage      = "https://github.com/iadbox/fluentdly"
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
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "fluent-logger"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-coolline"
  spec.add_development_dependency "rack"
end
