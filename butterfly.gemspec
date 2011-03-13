# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "butterfly/version"

Gem::Specification.new do |s|
  s.name        = "butterfly"
  s.version     = Butterfly::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Steve Hoeksema"]
  s.email       = ["steve@seven.net.nz"]
  s.homepage    = ""
  s.summary     = "Social media aggregator"
  s.description = "Retrieves \"likes\" from various social media sites and presents them in a common format"

  s.rubyforge_project = "butterfly"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", ["~> 2"]
  s.add_development_dependency "autotest"
  s.add_development_dependency "autotest-fsevent" if RUBY_PLATFORM =~ /darwin/i
end