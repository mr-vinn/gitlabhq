require 'rails/generators/base'
require 'rails/generators/active_record'

module Gitlab
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../../config", __FILE__)

    include Rails::Generators::Migration

    argument :db_type, :type => :string, :default => "postgresql", :desc => "Specify the database type.  Valid database types are 'postgresql' (default) or 'mysql'", :banner => "database type"

    def copy_db_config
      template "database.yml.erb", "config/database.yml"
    end

    def copy_migrations
      migration_template "db/migrate/20140524184438_init_schema.rb", "db/migrate/init_schema.rb"
    end

    def copy_config_examples
      copy_file "aws.yml.example", "config/aws.yml"
      copy_file "gitlab.yml.example", "config/gitlab.yml"
      copy_file "resque.yml.example", "config/resque.yml"
      copy_file "unicorn.rb.example", "config/unicorn.rb"
      copy_file "unicorn.rb.example.development", "config/unicorn.rb.example.development"
    end

    def add_engine_route
      route "mount Gitlab::Engine => '/'"
    end

    def post_install_message
      puts <<-EOT.sub(/^ {8}/, '')
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
