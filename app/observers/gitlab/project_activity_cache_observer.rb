module Gitlab
  class ProjectActivityCacheObserver < BaseObserver
    observe Gitlab::Event

    def after_create(event)
      event.project.update_column(:last_activity_at, event.created_at) if event.project
    end
  end

end
