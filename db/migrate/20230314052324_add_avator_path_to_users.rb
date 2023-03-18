class AddAvatorPathToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :avatar_path, :string
    remove_column :users, :image_name, :string
  end
end
