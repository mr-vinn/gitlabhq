# == Notifiable concern
#
# Contains notification functionality shared between UsersProject and UsersGroup
#
module Gitlab
  module Concerns
    module Notifiable
      extend ActiveSupport::Concern

      included do
        validates :notification_level, inclusion: { in: Gitlab::Notification.project_notification_levels }, presence: true
      end

      def notification
        @notification ||= Gitlab::Notification.new(self)
      end
    end
  end
end
