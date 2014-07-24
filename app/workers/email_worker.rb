class EmailWorker
  include Sidekiq::Worker
  
  def perform(user,appointment)
    user_find=User.find(user)
    appointment_find=Appointment.find(appointment)
    ReminderMailer.send_email_reminder(user_find.email, appointment_find.title).deliver
    
  end
  
  
  
end