require 'rails/generators/base'
require 'rails/generators/active_record'

module Gitlab
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../../config", __FILE__)

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
      @app_host_name = ask("Enter the web server's fully-qualified host name, or leave it blank to use 'localhost':")
      @app_host_name = "localhost" if @app_host_name.blank?

      @app_os_user = ask("Enter the OS user that will run your application, or leave it blank to use 'git':")
      @app_os_user = "git" if @app_os_user.blank?

      @app_user_home = begin
        Etc.getpwnam(@app_os_user).dir
      rescue
        "/home/#{@app_os_user}"
      end

      @email_from_address = ask("Enter the email address from which Gitlab should send, or leave it blank to use 'gitlab@#{@app_host_name}':")
      @email_from_address = "gitlab@#{@app_host_name}" if @email_from_address.blank?

      @support_email_address = ask(<<-EOT.gsub(/^ {8}/, '').chomp
        Enter the email address of the support contact, or leave it blank to
        use the previously-entered address:
        EOT
      )
      @support_email_address = @email_from_address if @support_email_address.blank?

      template "gitlab.yml.erb", "config/gitlab.yml"
    end

    def add_engine_route
      route "mount Gitlab::Engine => '/'"
    end

    def post_install_message
      puts <<-EOT.gsub(/^ {8}/, '')
        Gitlab has copied some stuff into your app:

        * A #{db_type} database config file, config/database.yml
        * A database migration file to build the Gitlab schema
        * Default configuration files in config/*.yml and config/unicorn.rb*
          for Gitlab and its dependencies

        Before you do anything else, you should modify config/database.yml to
        suit your needs, then run `bundle exec rake db:migrate` to build the
        gitlab database schema.
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
