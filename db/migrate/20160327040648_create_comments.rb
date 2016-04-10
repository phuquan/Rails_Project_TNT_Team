class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :image_id
      t.string :context

      t.timestamps null: false
    end
  end
end
