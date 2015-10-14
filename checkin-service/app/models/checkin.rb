class Checkin < ActiveRecord::Base
	belongs_to :contact
	belongs_to :location
	has_many :rewards

	def self.points(user_id, location_id)
		checkins = Checkin.where(user_id: user_id, location_id: location_id)
		points_total = 0
		checkins.each { |checkin| points_total += checkin.points.to_i }
		points = points_total
	end

	def self.check_in(user_id, location_id, point_value)
		Checkin.create(user_id: user_id, location_id: location_id, points: 5)
	end
end
