class ReminderWorker
  include Sidekiq::Worker

  def perform(current_user, appointment)
    ReminderMailer.send_email_reminder(User.find(current_user).email,appointment)
  end
  
  
end

