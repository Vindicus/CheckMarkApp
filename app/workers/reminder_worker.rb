class ReminderWorker
  include Sidekiq::Worker

  def perform(user,appointment)
    ReminderMailer.send_email_reminder(user, appointment)
  end
  
  
end

