class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :body, null: false
      t.string :permalink, null: false
      t.boolean :is_public, null: false, default: 1

      t.timestamps
    end
  end
end
