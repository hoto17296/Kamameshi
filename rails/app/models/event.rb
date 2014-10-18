class Event < ActiveRecord::Base
  has_many :user_groups
  has_many :groups

  scope :current, -> { where('started_at <= ? AND ended_at >= ?', Date.today, Date.today).first }
  scope :recent, -> { order('started_at DESC').first }

  def participant
    user_groups.where is_participant: 1
  end

  def nonparticipant
    user_groups.where is_participant: 0
  end

  def unassigned
    participant.where group_id: nil
  end

  def self.inviting?
    self.current.present?
  end

  def inviting?
    started_at <= Date.today and ended_at >= Date.today
  end

end
