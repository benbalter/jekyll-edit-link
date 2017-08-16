# encoding: utf-8

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "jekyll-edit-link/version"

Gem::Specification.new do |s|
  s.name          = "jekyll-edit-link"
  s.version       = JekyllEditLink::VERSION
  s.authors       = ["Ben Balter"]
  s.email         = ["ben.balter@github.com"]
  s.homepage      = "https://github.com/benbalter/jekyll-edit-link"
  s.summary       = "A Jekyll plugin to generate edit on GitHub links."

  s.files         = `git ls-files app lib`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ["lib"]
  s.license       = "MIT"

  s.add_runtime_dependency "jekyll", "~> 3.0"
  s.add_development_dependency "rspec", "~> 3.5"
  s.add_development_dependency "rubocop", "~> 0.40"
end
