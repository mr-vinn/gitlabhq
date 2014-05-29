$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gitlab/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gitlab-engine"
  s.version     = Gitlab::VERSION
  s.authors     = ["Vince Okada"]
  s.email       = ["vokada@mrvinn.com"]
  s.homepage    = "https://github.com/mr-vinn/gitlabhq"
  s.summary     = "Project management and code hosting application."
  s.description = "The Gitlab Community Edition app packaged as a Rails mountable engine."

  s.files = Dir[
    "{app,db,lib,vendor}/**/*",
    "config/{initializers,locales}/*",
    "config/database.yml.erb",
    "config/*.example*",
    "LICENSE",
    "Rakefile",
    "README.rdoc",
    "gitlab-engine.gemspec",
    "VERSION"
  ]
  s.test_files = Dir["spec/controllers/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "protected_attributes"
  s.add_dependency 'rails-observers'

  # Default values for AR models
  s.add_dependency "default_value_for", "~> 3.0.0"

  # Supported DBs
  s.add_dependency "mysql2"
  s.add_dependency "pg"

  # Auth
  s.add_dependency "devise", '3.0.4'
  s.add_dependency "devise-async", '0.8.0'
  s.add_dependency 'omniauth', "~> 1.1.3"
  s.add_dependency 'omniauth-google-oauth2'
  s.add_dependency 'omniauth-twitter'
  s.add_dependency 'omniauth-github'

  # Extracting information from a git repository
  # Provide access to Gitlab::Git library
  s.add_dependency "gitlab_git", '~> 5.8'

  # Ruby/Rack Git Smart-HTTP Server Handler
  s.add_dependency 'gitlab-grack', '~> 2.0.0.pre'

  # LDAP Auth
  s.add_dependency 'gitlab_omniauth-ldap', '1.0.4'

  # Git Wiki
  s.add_dependency 'gollum-lib', '~> 3.0.0'

  # Language detection
  s.add_dependency "gitlab-linguist", "~> 3.0.0"

  # API
  s.add_dependency "grape", "~> 0.6.1"
  # Replace with rubygems when nesteted entities get released
  s.add_dependency "grape-entity", "~> 0.4.2"
  s.add_dependency 'rack-cors'

  # Email validation
  s.add_dependency "email_validator", "~> 1.4.0"

  # Format dates and times
  # based on human-friendly examples
  s.add_dependency "stamp"

  # Enumeration fields
  s.add_dependency 'enumerize'

  # Pagination
  s.add_dependency "kaminari", "~> 0.15.1"

  # HAML
  s.add_dependency "haml-rails"

  # Files attachments
  s.add_dependency "carrierwave"

  # for aws storage
  s.add_dependency "fog", "~> 1.14"
  s.add_dependency "unf"

  # Authorization
  s.add_dependency "six"

  # Seed data
  s.add_dependency "seed-fu"

  # Markdown to HTML
  s.add_dependency "redcarpet",     "~> 2.2.2"
  s.add_dependency "github-markup"

  # Diffs
  s.add_dependency 'diffy', '~> 3.0.3'

  # Asciidoc to HTML
  s.add_dependency  "asciidoctor"

  # Application server
  s.add_dependency "unicorn", '~> 4.6.3'
  s.add_dependency 'unicorn-worker-killer'

  # State machine
  s.add_dependency "state_machine"

  # Issue tags
  s.add_dependency "acts-as-taggable-on", '~> 3.2.3'

  # Background jobs
  s.add_dependency 'slim'
  s.add_dependency 'sinatra'
  s.add_dependency 'sidekiq', '2.17.0'

  # HTTP requests
  s.add_dependency "httparty"

  # Colored output to console
  s.add_dependency "colored"

  # GitLab settings
  s.add_dependency 'settingslogic'

  # Misc
  s.add_dependency "foreman"
  s.add_dependency 'version_sorter'

  # Cache
  s.add_dependency "redis-rails"

  # Campfire integration
  s.add_dependency 'tinder', '~> 1.9.2'

  # HipChat integration
  s.add_dependency "hipchat", "~> 0.14.0"

  # Flowdock integration
  s.add_dependency "gitlab-flowdock-git-hook", "~> 0.4.2"

  # Gemnasium integration
  s.add_dependency "gemnasium-gitlab-service", "~> 0.2"

  # Slack integration
  s.add_dependency "slack-notifier", "~> 0.3.2"

  # d3
  s.add_dependency "d3_rails", "~> 3.1.4"

  # underscore-rails
  s.add_dependency "underscore-rails", "~> 1.4.4"

  # Sanitize user input
  s.add_dependency "sanitize", '~> 2.0'

  # Protect against bruteforcing
  s.add_dependency "rack-attack"

  # Ace editor
  s.add_dependency 'ace-rails-ap'

  s.add_dependency "sass-rails", '~> 4.0.2'
  s.add_dependency "coffee-rails"
  s.add_dependency "uglifier"
  s.add_dependency "therubyracer"
  s.add_dependency 'turbolinks'
  s.add_dependency 'jquery-turbolinks'

  s.add_dependency 'select2-rails'
  s.add_dependency 'jquery-atwho-rails', "~> 0.3.3"
  s.add_dependency "jquery-rails"
  s.add_dependency "jquery-ui-rails"
  s.add_dependency "raphael-rails", "~> 2.1.2"
  s.add_dependency 'bootstrap-sass', '~> 3.0'
  s.add_dependency "font-awesome-rails", '~> 3.2'
  s.add_dependency "gitlab_emoji", "~> 0.0.1.1"
  s.add_dependency "gon", '~> 5.0.0'
  s.add_dependency 'nprogress-rails'

  s.add_dependency "gitlab_meta", '6.0'

  s.add_dependency "annotate", "~> 2.6.0.beta2"
  s.add_dependency "letter_opener"
  s.add_dependency 'quiet_assets', '~> 1.0.1'
  s.add_dependency 'rack-mini-profiler'

  # Better errors handler
  s.add_dependency 'better_errors'
  s.add_dependency 'binding_of_caller'

  s.add_dependency 'rails_best_practices'

  # Docs generator
  s.add_dependency "sdoc"

  # thin instead webrick
  s.add_dependency 'thin'
  s.add_development_dependency 'coveralls'
  # gem 'rails-dev-tweaks'
  s.add_development_dependency 'spinach-rails'
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "pry"
  s.add_development_dependency "awesome_print"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "launchy"
  s.add_development_dependency 'factory_girl_rails'

  # Prevent occasions where minitest is not bundled in packaged versions of ruby (see #3826)
  s.add_development_dependency 'minitest', '~> 4.7.0'

  # Generate Fake data
  s.add_development_dependency "ffaker"

  # Guard
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'guard-spinach'

  # Notification
  s.add_dependency 'rb-fsevent'
  s.add_dependency 'growl'
  s.add_dependency 'rb-inotify'

  # PhantomJS driver for Capybara
  s.add_development_dependency 'poltergeist', '~> 1.4.1'

  s.add_development_dependency 'jasmine', '2.0.0.rc5'

  s.add_development_dependency "spring", '1.1.1'
  s.add_development_dependency "spring-commands-rspec", '1.0.1'
  s.add_development_dependency "spring-commands-spinach", '1.0.0'
  s.add_development_dependency "simplecov"
  s.add_development_dependency "shoulda-matchers", "~> 2.1.0"
  s.add_development_dependency 'email_spec'
  s.add_development_dependency "webmock"
  s.add_development_dependency 'test_after_commit'
end
