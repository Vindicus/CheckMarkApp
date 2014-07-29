class Appointment < ActiveRecord::Base
 
  belongs_to :user
  has_many :invitations, :dependent => :destroy
  has_many :reminders
  accepts_nested_attributes_for :invitations, reject_if: proc { |attributes| attributes[:invite_email].blank? }, allow_destroy: true
  accepts_nested_attributes_for :reminders
  validates :title, :location, :time, presence: true
  validates_uniqueness_of :title, :scope => [:location, :description, :time], message: "This exact appointment already exists"
    

    private
    #For Create
    def self.invite_success?(appointment,current_user)
      bool_check=true
      appointment.reminders.each do |accept|
        accept.user_id = current_user.id
      end
      appointment.invitations.each do |invite|
         email_downcase=invite.invite_email.downcase
         if email_downcase != current_user.email
            if User.email_exist(email_downcase)
              invite.user_id=current_user.id
            else
               bool_check=false
            end
         else
        bool_check=false
          end
      end
      bool_check
    end
    #for update
    def self.update_success?(edit_appointment,current_user)
      bool_check=true
      edit_appointment.invitations.each do |invite|
         email_downcase=invite.invite_email.downcase
        if User.email_exist(email_downcase) && email_downcase != current_user.email || invite.invite_email.downcase === 'delete'
           invite.update_attributes(user_id: current_user.id)
        else
          Invitation.where(invite_email: invite.invite_email).destroy_all
          bool_check=false
        end
      end
      bool_check
    end
    

    
    #Sidekiq for setting up reminders based on user options
    def self.set_reminder(user_id,appointment_id)
      appointment=Appointment.find(appointment_id)
      self.find(appointment_id).reminders.each do |option|
        if option.phone_sms_accept === true
          SmsWorker.perform_at(appointment.time,user_id,appointment_id)
        end
        if option.email_accept === true
          ReminderMailer.delay_until(appointment.time).send_email_reminder(user_id, appointment_id)
        end
        if option.phone_number_accept === true
          PhoneWorker.perform_async(user_id,appointment_id)
        end
      end
    end
end
  
 
  
   