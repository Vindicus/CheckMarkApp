class ReminderMailer < ActionMailer::Base
   default from: "do-not-reply@checkmark.com"
  
  def send_email_reminder(user, appointment)
    mail(:to => user.email, :subject => "Email Reminder" )
  end
end
