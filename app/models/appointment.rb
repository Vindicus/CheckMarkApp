class Appointment < ActiveRecord::Base
 
  belongs_to :user
  has_many :invitations, :dependent => :destroy
  has_many :reminders
  accepts_nested_attributes_for :invitations, reject_if: proc { |attributes| attributes[:invite_email].blank? }, allow_destroy: true
  accepts_nested_attributes_for :reminders
  validates :title, :location, :date, :time, presence: true
  validates_uniqueness_of :title, :scope => [:location, :description, :time, :date], message: "This exact appointment already exists"
    
  #  def set_reminder
     # ReminderWorker.perform_async(self.user_id, self.title)
   # end
    
    def self.set_reminder(user_id,appointment_id)
      appointment=Appointment.find(appointment_id)
      self.find(appointment_id).reminders.each do |choose|
        if choose.phone_sms_accept === true
          SmsWorker.perform_at(appointment.time,user_id,appointment_id)
        end
        if choose.email_accept === true
          ReminderMailer.delay_until(appointment.time).send_email_reminder(user_id, appointment_id)
        end
      end
    end
end
  
 
  
   