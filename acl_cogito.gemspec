$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acl_cogito/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acl_cogito"
  s.version     = AclCogito::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Gökçe ASOVA"]
  s.email       = ["gokce@asova.com"]
  s.homepage    = "http://www.asova.com"
  s.summary     = "A fork of Opinio gem with support for bootstrap and custom CMS."
  s.description = "This is an engine used to add comments functionallity to rails 3 applications."
  s.license     = "MIT"

  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3"
  s.add_dependency( 'kaminari' )
  s.add_dependency( 'jquery-rails' )
  
  s.add_development_dependency "sqlite3"
end
