class CreateTrains < ActiveRecord::Migration
  def change
    create_table :trains do |t|
      t.string :from_station
      t.string :to_station
      t.boolean :departure
      t.datetime :datetime
      t.string :station
      t.boolean :actual_disruption
      t.boolean :unplanned_disruption
      t.text :message
      t.text :advice
      t.string :disruption_notification
      t.string :planned_travel_time
      t.string :actual_travel_time
      t.integer :departure_delay
      t.integer :arrival_delay
      t.datetime :planned_departure_time
      t.datetime :actual_departure_time
      t.datetime :plannend_arrival_time
      t.datetime :actual_arrival_time
      t.string :current_status
      t.string :track


      t.timestamps
    end
  end
end
