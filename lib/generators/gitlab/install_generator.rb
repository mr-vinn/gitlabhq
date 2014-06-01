require 'rails/generators/base'
require 'rails/generators/active_record'

module Gitlab
  class InstallGenerator < Rails::Generators::Base
    def source_paths
      [
        "#{Gitlab::Engine.root}/config",
        "#{Gitlab::Engine.root}/lib/generators/templates"
      ]
    end

    include Rails::Generators::Migration

    argument :db_type,
      :type => :string,
      :default => "postgresql",
      :desc => "Specify the database type.  Valid database types are 'postgresql' (default) or 'mysql'",
      :banner => "database type"

    def copy_db_config
      template "database.yml.erb", "config/database.yml"
    end

    def copy_migrations
      migration_template(
        "../db/migrate/20140524184438_init_schema.rb",
        "db/migrate/init_schema.gitlab.rb"
      )
    end

    def copy_dependency_configs
      copy_file "aws.yml.example", "config/aws.yml.example"
      copy_file "resque.yml.example", "config/resque.yml.example"

      copy_file "unicorn.rb.example", "config/unicorn.rb"
      copy_file "unicorn.rb.example.development", "config/unicorn.rb.example.development"
    end

    def copy_gitlab_config
      default_host_name = "localhost"
      @app_host_name = ask("Enter the web server's fully-qualified host name, or leave it blank to use '#{default_host_name}':")
      @app_host_name = default_host_name if @app_host_name.blank?

      default_os_user = "git"
      @app_os_user = ask("Enter the OS user that will run your application, or leave it blank to use '#{default_os_user}':")
      @app_os_user = default_os_user if @app_os_user.blank?

      @app_user_home = begin
        Etc.getpwnam(@app_os_user).dir
      rescue
        "/home/#{@app_os_user}"
      end

      default_from_address = "gitlab@#{@app_host_name}"
      @email_from_address = ask("Enter the 'from' email address that Gitlab should use for notifications, or leave it blank to use '#{default_from_address}':")
      @email_from_address = default_from_address if @email_from_address.blank?

      default_support_address = @email_from_address
      @support_email_address = ask("Enter the email address of the support contact, or leave it blank to use '#{default_support_address}':")
      @support_email_address = default_support_address if @support_email_address.blank?

      template "gitlab.yml.erb", "config/gitlab.yml"
    end

    def copy_initializers
      copy_file "initializers/session_store.rb", "config/initializers/session_store.rb"
      copy_file "initializers/mime_types.rb", "config/initializers/mime_types.rb"
      copy_file "initializers/kaminari_config.rb", "config/initializers/kaminari_config.rb"
      copy_file "initializers/rack_attack.rb.example", "config/initializers/rack_attack.rb"
    end

    def copy_scripts
    end

    def add_engine_route
      route "mount Gitlab::Engine => '/'"
    end

    def post_install_message
      puts <<-EOT.gsub(/^ {8}/, '').green
        Gitlab has copied some things into your app:

        * A #{db_type} database config file, config/database.yml
        * A database migration file to build the Gitlab schema
        * Scripts for command-line tasks
        * Default configuration files for Gitlab and Unicorn in config/
        * Example configuration files for Resque and AWS in config/
        * Initializers in config/initializers that should be modified as required

        Before you do anything else, you should modify config/database.yml to
        suit your needs, then run `bundle exec rake db:migrate` to build the
        gitlab database schema.

        Visit the engine's project website for more information about using
        Gitlab in your application: https://github.com/mr-vinn/gitlabhq

        For more information about Gitlab in general, check out Gitlab's
        website: https://www.gitlab.com/documentation/
      EOT
    end

    private

    def self.next_migration_number(dirname)
      ActiveRecord::Generators::Base.next_migration_number dirname
    end

    def app_name
      Rails.application.class.parent_name.underscore
    end

    def adapter_name
      case db_type
      when 'postgresql' then :postgresql
      when 'mysql' then :mysql2
      else raise("Unsupported database type '#{db_type}'")
      end
    end
  end
end
