class RemoveDeletedAtFromUsers < ActiveRecord::Migration[5.1]
  def up
    remove_column :users, :deleted_at
  end
end
