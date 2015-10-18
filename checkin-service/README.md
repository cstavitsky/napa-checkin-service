# Simple Checkin Service

This is a simple checkin service built off of Bellycard's Napa. APIs exist to access Users, Locations, Checkins, and Rewards. 

## What constitutes a Checkin?

There are several methods written for a Checkin that simulate real-life loyalty program use, similar to the Belly service. The Checkin model has a variety of class methods:

- self.points(user_id, location_id) --> Calculates the number of points associated with a particular user and location. 'Points' for a given user/location combination is not a static total, but rather is calculated each time the points method is called. The method looks for all Checkin objects that meet the user/location criteria and adds up their point values. 

- self.check_in(user_id, location_id, point_value) --> Creates a new checkin object. There are limitations on this. If a specific user has checked in within the last 12 hours to a specific location, the method will return a failure string; if the user has not yet checked in to the location, or more than 12 hours have elapsed, a new Checkin will be instantiated.

- self.redeem_points(reward, user_id, location_id) --> If the user has enough points, then a new Checkin with a negative point value is instantiated. This way, when the self.points method is called, the user's point total will reflect the redeemed_points. 
