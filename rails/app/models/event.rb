class Event < ActiveRecord::Base
  has_many :user_groups
  has_many :groups

  def participant
    user_groups.where is_participant: 1
  end

  def nonparticipant
    user_groups.where is_participant: 0
  end

  def unassigned
    participant.where group_id: nil
  end

end
