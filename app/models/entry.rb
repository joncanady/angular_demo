class Entry < ActiveRecord::Base
  attr_accessible :name, :avatar_url, :winner
  validates_presence_of :name
end
