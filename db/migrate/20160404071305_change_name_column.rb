class ChangeNameColumn < ActiveRecord::Migration
  def change
    rename_column :images, :owner_id, :user_id
    add_foreign_key :images, :users
  end
end