# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "github-hook/version"

Gem::Specification.new do |s|
  s.name        = "github-hook"
  s.version     = Github::Hook::VERSION
  s.authors     = ["George Guimarães"]
  s.email       = ["george@plataformatec.com.br"]
  s.homepage    = ""
  s.summary     = %q{ hook them all }
  s.description = %q{ github-hook creates and deletes hooks in your github repository }

  s.rubyforge_project = "github-hook"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rest-client", "~> 1.6.7"
  s.add_dependency "thor", "~> 0.14.6"
  s.add_dependency "activesupport", "~> 3.0"
end
