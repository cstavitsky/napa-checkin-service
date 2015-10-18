require 'time_difference'

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
		if self.ok_to_checkin?(user_id, location_id, point_value)
		 	new_checkin = Checkin.create(user_id: user_id, location_id: location_id, points: 5)
		else
			self.checkin_failed(user_id, location_id, point_value)
		end
		new_checkin
	end

	def self.redeem_points(reward, user_id, location_id)
		if Checkin.points(user_id, location_id) >= reward.point_value
			Checkin.create(user_id: user_id, location_id: location_id, points: -reward.point_value)
		else
			false
		end
	end

	def object_type
		self.class.name.underscore
	end

	def self.ok_to_checkin?(user_id, location_id, point_value)
		# can check in if it's been 12+ hours
		last_checkin = self.last_checkin_time(user_id, location_id, point_value)
		time_elapsed = TimeDifference.between(last_checkin, Time.now.getutc).in_hours
		if (time_elapsed >= 12) || last_checkin == nil
			true
		else
			false
		end
	end

	def self.last_checkin_time(user_id, location_id, point_value)
		if Checkin.where(user_id: user_id, location_id: location_id).last.created_at
			Checkin.where(user_id: user_id, location_id: location_id).last.created_at
		else
			0
		end
	end

	# def self.checkin_failed(user_id,location_id, point_value)
	# 	last_checkin = self.last_checkin_time(user_id,location_id, point_value)
	# 	"Please wait " + (1440 - (Time.now.getutc - last_checkin_time)/60).to_i.to_s + " minutes before checking in"
	# end

end
