class UserGroup < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :event

  serialize :answers, Array

  def leader?
    group.present? and id === group.leader_id
  end
end
