require 'rails-observers'
require 'gitlab_emoji'
require 'rack/attack'
require 'rack/cors'
require 'virtus'
require 'rack/mount'
require 'grape'
require 'grape_entity/entity'
require 'protected_attributes'
require 'enumerize'
require 'default_value_for'
require 'kaminari'
require 'haml/util'
require 'haml/template'
require 'devise'
require 'devise/async'
require 'carrierwave'
require 'sidekiq'
require 'acts-as-taggable-on'
require 'httparty'
require 'state_machine'
require 'email_validator/strict'
require 'linguist'
require 'grack'
require 'gitlab_git'
require 'settingslogic'
require 'six'
require 'jquery-rails'
require 'jquery-turbolinks'
require 'jquery-ui-rails'
require 'jquery-atwho-rails'
require 'select2-rails'
require 'nprogress-rails'
require 'bootstrap-sass'
require 'font-awesome-rails'
require 'turbolinks'
require 'raphael-rails'
require 'ace-rails-ap'
require 'd3_rails'
require 'underscore-rails'
require 'stamp'
require 'redcarpet'
require 'version_sorter'
require 'letter_opener'
require 'diffy'
require 'omniauth-ldap'
require 'sass-rails'
require 'seed-fu'
require 'coffee_script'
require 'sanitize'

if RbConfig::CONFIG['host_os'] =~ /linux/
  require 'rb-inotify'
elsif RbConfig::CONFIG['host_os'] =~ /darwin/
  require 'rb-fsevent'
  require 'growl'
end

module Gitlab
  class Engine < ::Rails::Engine
    isolate_namespace Gitlab

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib #{config.root}/app/finders #{config.root}/app/models/gitlab/concerns #{config.root}/app/models/gitlab/project_services)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    config.active_record.observers = 'Gitlab::MilestoneObserver',
                                     'Gitlab::ProjectActivityCacheObserver',
                                     'Gitlab::NoteObserver',
                                     'Gitlab::ProjectObserver',
                                     'Gitlab::SystemHookObserver',
                                     'Gitlab::UserObserver',
                                     'Gitlab::UsersGroupObserver',
                                     'Gitlab::UsersProjectObserver'

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Gitlab::Engine.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.enforce_available_locales = false

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    initializer "gitlab.params.filter" do |app| 
      app.config.filter_parameters += [:password] 
    end 
    

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true
    config.assets.paths << Emoji.images_path
    config.assets.precompile << "emoji/*.png"
    config.assets.precompile << "print.css"

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # Relative url support
    # Uncomment and customize the last line to run in a non-root path
    # WARNING: We recommend creating a FQDN to host GitLab in a root path instead of this.
    # Note that following settings need to be changed for this to work.
    # 1) In your application.rb file: config.relative_url_root = "/gitlab"
    # 2) In your gitlab.yml file: relative_url_root: /gitlab
    # 3) In your unicorn.rb: ENV['RAILS_RELATIVE_URL_ROOT'] = "/gitlab"
    # 4) In ../gitlab-shell/config.yml: gitlab_url: "http://127.0.0.1/gitlab"
    # 5) In lib/support/nginx/gitlab : do not use asset gzipping, remove block starting with "location ~ ^/(assets)/"
    #
    # To update the path, run: sudo -u git -H bundle exec rake assets:precompile RAILS_ENV=production
    #
    # config.relative_url_root = "/gitlab"

    config.middleware.use Rack::Attack

    # Allow access to GitLab API from other domains
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '/api/*', headers: :any, methods: [:get, :post, :options, :put, :delete]
      end
    end
  end
end