# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "iactionable/version"

Gem::Specification.new do |s|
  s.name        = "ruby-iactionable"
  s.version     = IActionable::VERSION
  s.authors     = ["Chris Eberz"]
  s.email       = ["ceberz@elctech.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby wrapper for IActionable's restful API.}
  s.description = %q{Ruby wrapper for IActionable's restful API.}

  s.rubyforge_project = "ruby-iactionable"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib", "spec"]


  s.add_development_dependency "rspec", ">= 2.6"
  s.add_development_dependency "yard"

  s.add_runtime_dependency "faraday"
  s.add_runtime_dependency "faraday_middleware", '~> 0.8.7'
  s.add_runtime_dependency "activesupport", ">= 3.0.0"
end
