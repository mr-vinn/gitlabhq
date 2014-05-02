module Gitlab
  class Profiles::AccountsController < ApplicationController
    layout "gitlab/profile"

    def show
      @user = current_user
    end
  end
end
