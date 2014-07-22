class AddTimeToAppointments < ActiveRecord::Migration
  def change
     add_column :appointments, :time, :datetime
  end
end
