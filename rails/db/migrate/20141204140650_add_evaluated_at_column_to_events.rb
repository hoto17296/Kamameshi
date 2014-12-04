class AddEvaluatedAtColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :evaluated_at, :date
  end
end
