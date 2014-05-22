# Be sure to restart your server when you modify this file.

Gitlab::Engine.initializer 'gitlab.session_store' do |app|
  app.config.session_store(
    :redis_store, # Using the cookie_store would enable session replay attacks.
    servers: Gitlab::Engine.config.cache_store[1], # re-use the Redis config from the Rails cache store
    key: '_gitlab_session',
    secure: Gitlab.config.gitlab.https,
    httponly: true,
    path: (Rails.application.config.relative_url_root.nil?) ? '/' : Rails.application.config.relative_url_root
  )
end
