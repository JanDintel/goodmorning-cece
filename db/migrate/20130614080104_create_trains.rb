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


      t.timestamps
    end
  end
end
