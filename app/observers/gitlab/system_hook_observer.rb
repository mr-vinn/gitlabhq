module Gitlab
  class SystemHookObserver < BaseObserver
    observe :'gitlab/user', :'gitlab/project', :'gitlab/users_project'

    def after_create(model)
      system_hook_service.execute_hooks_for(model, :create)
    end

    def after_destroy(model)
      system_hook_service.execute_hooks_for(model, :destroy)
    end

    private

    def system_hook_service
      SystemHooksService.new
    end
  end
end
