class Train < ActiveRecord::Base
  attr_accessible :from_station, :to_station, :departure, :datetime, :station, :actual_disruption, :unplanned_disruption, :message, :advice
