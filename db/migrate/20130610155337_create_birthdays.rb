class CreateBirthdays < ActiveRecord::Migration
  def change
    create_table :birthdays do |t|
      t.integer :facebook_id
      t.text :date
      t.string :name
      t.references :user

      t.timestamps
    end
  end
end
