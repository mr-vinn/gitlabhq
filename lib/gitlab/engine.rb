module Gitlab
  class Engine < ::Rails::Engine
    isolate_namespace Gitlab
  end
end
