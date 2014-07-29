require 'twilio-ruby'
class SmsWorker
  include TwilioHelper
  include Sidekiq::Worker

  def perform(user,appointment)
    user_find=User.find(user)
    appointment_find=Appointment.find(appointment)
    @@Client.account.messages.create(
      :from => '+12096473083',
      :to => "+#{user_find.phone_number}",
      :body => "hello, #{user_find.first_name}. You have an appointment called: #{appointment_find.title} coming up. Please see CheckMark for details. Thank you, good bye."
)
  end

  
end
