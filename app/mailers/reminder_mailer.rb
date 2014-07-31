class ReminderMailer < ActionMailer::Base
  default from: "do-not-reply@checkmark.com"
  
  #Sends an email to the user using Sendgrid
  def send_email_reminder(user, appointment)
    @user=User.find(user)
    @appointment=Appointment.find(appointment)
    
    mail(:to => @user.email, :subject => "Your appointment reminder" )
  end
end
