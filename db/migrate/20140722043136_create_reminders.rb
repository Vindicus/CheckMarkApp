class CreateReminders < ActiveRecord::Migration
  def change
      create_table :reminders do |t|
      t.belongs_to :appointment
      t.boolean :email_accept
      t.boolean :phone_number_accept
      t.boolean :phone_sms_accept
      t.belongs_to :user
      t.timestamps
    end
  end
end
