class ReminderMailer < ActionMailer::Base
   default from: "do-not-reply@checkmark.com"
  
  def send_email_reminder(user, appointment)
     @user=User.find(user)
     @appointment=Appointment.find(appointment)
    mail(:to => @user.email, :subject => "Your appointment reminder" )
  end
end
