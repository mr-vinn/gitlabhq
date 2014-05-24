# == Schema Information
#
# Table name: keys
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  key         :text
#  title       :string(255)
#  type        :string(255)
#  fingerprint :string(255)
#

module Gitlab
  class DeployKey < Key
    has_many :deploy_keys_projects, dependent: :destroy, class_name: Gitlab::DeployKeysProject
    has_many :projects, through: :deploy_keys_projects, class_name: Gitlab::Project

    scope :in_projects, ->(projects) { joins(:deploy_keys_projects).where('gitlab_deploy_keys_projects.project_id in (?)', projects) }
  end
end
