class Group < ActiveRecord::Base
  belongs_to :event
  belongs_to :leader, class_name: 'UserGroup', foreign_key: :leader_id
  has_many :user_groups
end
