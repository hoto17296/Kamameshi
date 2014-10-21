class AddPostAndSkypeColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :post_id, :integer
    add_column :users, :skype_id, :string
  end
end
