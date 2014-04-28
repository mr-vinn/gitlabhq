# == Schema Information
#
# Table name: snippets
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  author_id  :integer          not null
#  project_id :integer
#  created_at :datetime
#  updated_at :datetime
#  file_name  :string(255)
#  expires_at :datetime
#  private    :boolean          default(TRUE), not null
#  type       :string(255)
#

module Gitlab
  class ProjectSnippet < Snippet
    belongs_to :project
    belongs_to :author, class_name: "User"

    validates :project, presence: true

    # Scopes
    scope :fresh, -> { order("created_at DESC") }
    scope :non_expired, -> { where(["expires_at IS NULL OR expires_at > ?", Time.current]) }
    scope :expired, -> { where(["expires_at IS NOT NULL AND expires_at < ?", Time.current]) }
  end
end
