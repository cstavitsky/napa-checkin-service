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
      return new_checkin = Checkin.create!(user_id: user_id, location_id: location_id, points: 5)
    else
      return checkin_failed(12)
    end
  end

  def self.redeem_points(reward, user_id, location_id)
    if Checkin.points(user_id, location_id) >= reward.point_value
      reward.times_redeemed += 1
      Checkin.create!(user_id: user_id, location_id: location_id, points: -reward.point_value)
    else
      false
    end
  end

  def object_type
    self.class.name.underscore
  end

  def self.ok_to_checkin?(user_id, location_id, point_value)
    # can check in if it's been 12+ hours
    p time_elapsed = time_since_last_checkin(user_id, location_id, point_value)
    if (time_elapsed >= 720) || time_elapsed == 0
      true
    else
      false
    end
  end

  def self.time_since_last_checkin(user_id, location_id, _point_value)
    if Checkin.where(user_id: user_id, location_id: location_id).length > 0
      p TimeDifference.between(Checkin.where(user_id: user_id, location_id: location_id).last.created_at, Time.now.getutc).in_minutes
    else
      0
    end
  end

  def self.checkin_failed(time)
    "You can't check in again to this location so soon. Please wait until #{time} hours have passed since your last checkin."
  end
end
