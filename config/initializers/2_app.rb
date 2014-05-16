require 'gitlab/popen'

# ==> Devise ORM configuration
# Load and configure the ORM. Supports :active_record (default) and
# :mongoid (bson_ext recommended) by default. Other ORMs may be
# available as additional gems.
#
# This is normally set in the Devise initializer, but it's included here so
# that libs can be loaded.
require 'devise/orm/active_record'

module Gitlab
  VERSION = File.read(Rails.root.join("VERSION")).strip
  REVISION = Gitlab::Popen.popen(%W(git log --pretty=format:%h -n 1)).first.chomp

  def self.config
    Settings
  end
end

#
# Load all libs for threadsafety
#
#Dir["#{Gitlab::Engine.root}/lib/**/*.rb"].each { |file| require file }
