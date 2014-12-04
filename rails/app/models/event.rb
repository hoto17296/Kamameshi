class Event < ActiveRecord::Base
  has_many :user_groups
  has_many :groups

  serialize :questions, Array

  before_save :remove_empty_questions

  scope :current, -> { where('invited_at <= ? AND closed_at >= ?', Date.today, Date.today) }
  scope :recent, -> { where('invited_at <= ?', Date.today).order('invited_at DESC') }

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
    self.current.first.present?
  end

  def inviting?
    invited_at <= Date.today and closed_at >= Date.today
  end

  private
    def remove_empty_questions
      self.questions = questions.select{|v| !v.rstrip.empty? }
    end
end
