require 'rails/generators/base'

module Gitlab
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../../config", __FILE__)

    def copy_config
      copy_file "gitlab.yml.example", "config/gitlab.yml"
    end
  end
end
