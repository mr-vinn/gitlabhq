require 'rails/generators/base'

module Gitlab
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../../config", __FILE__)

    def copy_config_examples
      copy_file "aws.yml.example", "config/aws.yml"
      copy_file "gitlab.yml.example", "config/gitlab.yml"
      copy_file "resque.yml.example", "config/resque.yml"
      copy_file "unicorn.rb.example", "config/unicorn.rb"
      copy_file "unicorn.rb.example.development", "config/unicorn.rb.example.development"
    end
    end
  end
end
