class AddDiscardedAtToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :discarded_at, :datetime
  end
end
