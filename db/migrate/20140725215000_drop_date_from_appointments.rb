class DropDateFromAppointments < ActiveRecord::Migration
  def change
    def change
      remove_column :appointments, :date
    end
  end
end
