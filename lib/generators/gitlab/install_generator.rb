require 'rails/generators/base'

module Gitlab
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../../config", __FILE__)

    argument :db_type, :type => :string, :default => "postgresql", :desc => "Specify the database type.  Valid database types are 'postgresql' (default) or 'mysql'", :banner => "database type"

    def copy_db_config
      template "database.yml.erb", "config/database.yml"
    end

    def copy_config_examples
      copy_file "aws.yml.example", "config/aws.yml"
      copy_file "gitlab.yml.example", "config/gitlab.yml"
      copy_file "resque.yml.example", "config/resque.yml"
      copy_file "unicorn.rb.example", "config/unicorn.rb"
      copy_file "unicorn.rb.example.development", "config/unicorn.rb.example.development"
    end

    private

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
