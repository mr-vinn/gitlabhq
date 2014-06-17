# Be sure to restart your server when you modify this file.

require 'redis-rails'

<%= app_class_name %>::Application.config.session_store(
  :redis_store, # Using the cookie_store would enable session replay attacks.
  servers: Rails.application.config.cache_store[1], # re-use the Redis config from the Rails cache store
  key: '_<%= app_name %>_session',
  secure: Gitlab.config.gitlab.https,
  httponly: true,
  path: (Rails.application.config.relative_url_root.nil?) ? '/' : Rails.application.config.relative_url_root
)
