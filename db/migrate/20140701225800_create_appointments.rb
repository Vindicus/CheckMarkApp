class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :title
      t.text :description
      t.string :location
      t.date :date
      t.time :time

      t.belongs_to :user
      t.timestamps
      
    end
  end
end
