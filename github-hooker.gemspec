# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "github-hooker/version"

Gem::Specification.new do |s|
  s.name        = "github-hooker"
  s.version     = Github::Hooker::VERSION
  s.authors     = ["George Guimarães"]
  s.email       = ["george@plataformatec.com.br"]
  s.homepage    = ""
  s.summary     = %q{ hook them all }
  s.description = %q{ hook them all }

  s.rubyforge_project = "github-hooker"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
