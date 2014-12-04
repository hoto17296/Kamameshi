class RenameStartedAtToInvitedAt < ActiveRecord::Migration
  def change
    rename_column :events, :started_at, :invited_at
  end
end
