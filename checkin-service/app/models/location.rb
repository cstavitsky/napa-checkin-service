class Location < ActiveRecord::Base
	attr_reader :id
	
	has_many :checkins
	has_many :users, :through => :checkins
end
