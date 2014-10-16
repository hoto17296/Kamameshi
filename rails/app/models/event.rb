class Event < ActiveRecord::Base
  has_many :user_groups
  has_many :groups
end
