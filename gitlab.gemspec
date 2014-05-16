$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gitlab/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gitlab"
  s.version     = Gitlab::VERSION
  s.authors     = ["Vince Okada"]
  s.email       = ["vokada@mrvinn.com"]
  s.homepage    = "https://github.com/mr-vinn/gitlabhq"
  s.summary     = "Project management and code hosting application."
  s.description = "The Gitlab Community Edition app packaged as a Rails mountable engine."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.5"

  s.add_development_dependency "sqlite3"
end
