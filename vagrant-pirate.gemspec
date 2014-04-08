# -*- encoding: utf-8 -*-
require File.expand_path('../lib/vagrant-pirate/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "vagrant-pirate"
  s.version     = Pirate::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Christopher Gervais"]
  s.email       = ["chris@ergonlogic.com"]
  s.license     = 'GPL'
  s.homepage    = "https://github.com/PraxisLabs/vagrant-pirate"
  s.summary     = %q{A Vagrant plugin that allows configuration via YAML}
  s.description = %q{A Vagrant plugin that allows configuration via YAML}

  s.required_ruby_version = '>= 2.0.0'
  s.required_rubygems_version = ">= 1.3.6"

  s.add_development_dependency "cucumber"
  s.add_development_dependency "aruba"
  s.add_development_dependency "rake"
  s.add_development_dependency "simplecov", '~> 0.7.1'
  s.add_development_dependency "coveralls"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

end
