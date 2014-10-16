class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
      t.references :user, index: true, null: false
      t.references :group, index: true
      t.references :event, index: true, null: false
      t.text :answers

      t.timestamps
    end
  end
end
