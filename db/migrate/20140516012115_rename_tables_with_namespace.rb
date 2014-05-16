class RenameTablesWithNamespace < ActiveRecord::Migration
  def change
    rename_table :broadcast_messages, :gitlab_broadcast_messages
    rename_table :deploy_keys_projects, :gitlab_deploy_keys_projects
    rename_table :emails, :gitlab_emails
    rename_table :events, :gitlab_events
    rename_table :forked_project_links, :gitlab_forked_project_links
    rename_table :issues, :gitlab_issues
    rename_table :keys, :gitlab_keys
    rename_table :merge_request_diffs, :gitlab_merge_request_diffs
    rename_table :merge_requests, :gitlab_merge_requests
    rename_table :milestones, :gitlab_milestones
    rename_table :namespaces, :gitlab_namespaces
    rename_table :notes, :gitlab_notes
    rename_table :projects, :gitlab_projects
    rename_table :protected_branches, :gitlab_protected_branches
    rename_table :services, :gitlab_services
    rename_table :snippets, :gitlab_snippets
    rename_table :tags, :gitlab_tags
    rename_table :users, :gitlab_users
    rename_table :users_groups, :gitlab_users_groups
    rename_table :users_projects, :gitlab_users_projects
    rename_table :web_hooks, :gitlab_web_hooks
    rename_index :taggings, :index_taggings_on_taggable_id_and_taggable_type_and_context, :index_taggings_on_taggable_id_taggable_type_context
    rename_table :taggings, :gitlab_taggings
  end
end
