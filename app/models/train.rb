class Train < ActiveRecord::Base
  attr_accessible :from_station, :to_station, :departure, :datetime, :station, :actual_disruption, :unplanned_disruption, :message, :advice,
  :disruption_notification, :planned_travel_time, :actual_travel_time, :departure_delay, :arrival_delay, :planned_departure_time, :actual_departure_time,
  :plannend_arrival_time, :actual_arrival_time, :current_status, :track
end
  
