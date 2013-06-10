class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.float :temperature
      t.float :windspeed
      t.text  :date
      t.integer :humidity
      
      t.timestamps
    end
  end
end
