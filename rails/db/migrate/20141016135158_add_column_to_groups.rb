class AddColumnToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :event_id, :integer, null: false
    add_index :groups, :event_id
  end
end
