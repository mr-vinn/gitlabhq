require 'simplecov' unless ENV['CI']

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

ENV['RAILS_ENV'] = 'test'
require File.expand_path("../../../spec/dummy/config/environment", __FILE__)

require 'rspec'
require 'rspec/expectations'
require 'database_cleaner'
require 'capybara/rails'
require 'spinach/capybara'
require 'sidekiq/testing/inline'
require 'webmock'
require 'factory_girl'
require 'ffaker'

%w(valid_commit valid_commit_with_alt_email big_commits select2_helper test_env).each do |f|
  require Gitlab::Engine.root.join('spec', 'support', f)
end

Dir["#{Gitlab::Engine.root}/features/steps/shared/*.rb"].each {|file| require file}

# Require factories in spec/factories/ and spec/factories.rb
require Gitlab::Engine.root.join('spec', 'factories')
Dir["#{Gitlab::Engine.root}/spec/factories/**/*.rb"].each {|f| require f }

WebMock.allow_net_connect!
#
# JS driver
#
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, :js_errors => false, :timeout => 60)
end
Spinach.hooks.on_tag("javascript") do
  ::Capybara.current_driver = ::Capybara.javascript_driver
end
Capybara.default_wait_time = 60
Capybara.ignore_hidden_elements = false

DatabaseCleaner.strategy = :truncation

Spinach.hooks.before_scenario do
  include Gitlab::TestEnv
  Gitlab::TestEnv.setup_stubs
  DatabaseCleaner.start
end

Spinach.hooks.after_scenario do
  DatabaseCleaner.clean
end

Spinach.hooks.before_run do
  Gitlab::TestEnv.init(mailer: false, init_repos: true, repos: false)
  RSpec::Mocks::setup self

  include FactoryGirl::Syntax::Methods
end
