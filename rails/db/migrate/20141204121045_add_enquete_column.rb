class AddEnqueteColumn < ActiveRecord::Migration
  def change
    add_column :events, :after_questions, :text
    add_column :user_groups, :after_answers, :text
  end
end
