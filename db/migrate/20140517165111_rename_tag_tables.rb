class RenameTagTables < ActiveRecord::Migration
  def change
    rename_table :gitlab_tags, :tags
    rename_table :gitlab_taggings, :taggings
    rename_index :taggings, :index_taggings_on_taggable_id_taggable_type_context, :index_taggings_on_taggable_id_and_taggable_type_and_context
  end
end
