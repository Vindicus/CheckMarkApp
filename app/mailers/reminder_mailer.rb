class ReminderMailer < ActionMailer::Base
   default from: "do-not-reply@checkmark.com"
  
   def send_email_reminder(invitee,appointment)
    @invitee=invitee
    @appointment=appointment
     mail(:to => @invitee.email, :subject => "Email Reminder" )
  end
end
