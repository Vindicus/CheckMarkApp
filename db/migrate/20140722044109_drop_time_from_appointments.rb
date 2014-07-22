class DropTimeFromAppointments < ActiveRecord::Migration
  def change
    remove_column :appointments, :time
  end
end
