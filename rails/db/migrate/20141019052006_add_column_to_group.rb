class AddColumnToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :leader_id, :integer
    add_index :groups, :leader_id
  end
end
