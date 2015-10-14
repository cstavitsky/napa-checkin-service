class User < ActiveRecord::Base
	has_many :checkins
	has_many :locations, through: :checkins
end
