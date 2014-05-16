# GIT over HTTP
require Gitlab::Engine.root.join("lib", "gitlab", "backend", "grack_auth")

# GIT over SSH
require Gitlab::Engine.root.join("lib", "gitlab", "backend", "shell")

# GitLab shell adapter
require Gitlab::Engine.root.join("lib", "gitlab", "backend", "shell_adapter")
