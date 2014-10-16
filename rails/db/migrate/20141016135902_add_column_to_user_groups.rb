class AddColumnToUserGroups < ActiveRecord::Migration
  def change
    add_column :user_groups, :is_participant, :boolean, null: false, default: 0
  end
end
