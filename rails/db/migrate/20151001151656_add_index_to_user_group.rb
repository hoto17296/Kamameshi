class AddIndexToUserGroup < ActiveRecord::Migration
  def change
    add_index :user_groups, [:user_id, :event_id], unique: true, name: 'user_event_unique'
  end
end
