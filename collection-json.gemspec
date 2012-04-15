# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "collection-json/version"

Gem::Specification.new do |s|
  s.name        = "collection-json"
  s.version     = CollectionJSON::VERSION
  s.authors     = ["Sebastian Edwards"]
  s.email       = ["sebastian@uprise.co.nz"]
  s.homepage    = "https://github.com/sebastianedwards/collection-json"
  s.summary     = %q{Builds Collection+JSON responses.}
  s.description = %q{Lightweight gem for building Collection+JSON responses.}

  s.rubyforge_project = "collection-json"

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
end
