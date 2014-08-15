# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)

require 'simplecov' unless ENV['CI']

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'webmock/rspec'
require 'email_spec'
require 'sidekiq/testing/inline'
require 'capybara/poltergeist'
require 'ffaker'
require 'sanitize'
require 'factory_girl'
require 'factories'
require 'shoulda-matchers'

module Gitlab
  Capybara.javascript_driver = :poltergeist
  Capybara.default_wait_time = 10

  ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

  # Require factories in spec/factories/
  Dir[File.join(ENGINE_RAILS_ROOT, "spec/factories/**/*.rb")].each {|f| require f }

  WebMock.disable_net_connect!(allow_localhost: true)

  RSpec.configure do |config|
    config.use_transactional_fixtures = false
    config.use_instantiated_fixtures  = false
    config.mock_with :rspec

    config.include LoginHelpers, type: :feature
    config.include LoginHelpers, type: :request
    config.include FactoryGirl::Syntax::Methods
    config.include Devise::TestHelpers, type: :controller

    # Make the engine's routes available to Rspec
    config.include Gitlab::Engine.routes.url_helpers
    route_module = Module.new {
      def self.included(base)
        base.routes { Gitlab::Engine.routes }
      end 
    }
    config.include route_module, type: :routing
    config.include route_module, type: :controller

    config.include TestEnv

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.

    config.before(:suite) do
      TestEnv.init(init_repos: true, repos: false)
    end
    config.before(:each) do
      TestEnv.setup_stubs
    end
  end
end
