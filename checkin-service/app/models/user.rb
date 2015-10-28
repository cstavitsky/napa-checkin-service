class User < ActiveRecord::Base
  attr_reader :id

  has_many :checkins
  has_many :locations, through: :checkins
end
