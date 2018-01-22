class ChangeUsersStructure < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :image, :string
    remove_column :users, :first_name, :boolean
    remove_column :users, :last_name, :boolean

  end
end
