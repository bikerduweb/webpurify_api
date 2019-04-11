# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webpurify_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'webpurify_api'
  spec.version       = WebpurifyApi::VERSION
  spec.authors       = ['Olivier']
  spec.email         = ['olivier@veilleperso.com']
  spec.summary       = %q{Small wrapper aroud webpurify.com image moderation api.}
  spec.description   = %q{Wrapper for webpurify.com image moderation api, built for my own needs.}
  spec.homepage      = 'https://github.com/veilleperso/webpurify_api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_runtime_dependency 'rest-client', '~> 2.0.2'
  spec.add_runtime_dependency 'activesupport', '~> 5.0'
end
