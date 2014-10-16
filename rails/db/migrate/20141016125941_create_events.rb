class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :questions
      t.date :started_at, null: false
      t.date :ended_at, null: false

      t.timestamps
    end
  end
end
