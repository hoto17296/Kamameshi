class Event < ActiveRecord::Base
  has_many :user_groups, :groups
end