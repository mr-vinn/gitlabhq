require 'devise'
require "gitlab/engine"

module Gitlab
  mattr_accessor :user_class

  def self.user_class
    @@author_class.constantize
  end
end
