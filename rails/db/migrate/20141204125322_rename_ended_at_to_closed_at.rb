class RenameEndedAtToClosedAt < ActiveRecord::Migration
  def change
    rename_column :events, :ended_at, :closed_at
  end
end
