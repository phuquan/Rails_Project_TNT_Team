class AddOtherColumns < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :birthdate, :datetime
    add_column :users, :introduction, :string
  end
end
