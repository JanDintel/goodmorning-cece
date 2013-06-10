class Weather < ActiveRecord::Base
  attr_accessible :temperature, :windspeed, :date, :humidity
end
