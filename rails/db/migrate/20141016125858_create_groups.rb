class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :iqube_url

      t.timestamps
    end
  end
end
