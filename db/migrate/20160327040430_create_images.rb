class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :owner_id
      t.boolean :is_shared
      t.string :url
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
