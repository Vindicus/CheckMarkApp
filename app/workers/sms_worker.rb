require 'twilio-ruby'
class SmsWorker
  include Sidekiq::Worker

  def perform(user,appointment)
    account_sid = 'AC3473ee64394d1509ba3c30c111f3c3d6'
    auth_token = 'fb79802b4f2554463abc35a9c52b3895'
    @client = Twilio::REST::Client.new account_sid, auth_token
    user_find=User.find(user)
    appointment_find=Appointment.find(appointment)
    @client.account.messages.create(
      :from => '+12096473083',
      :to => "+#{user_find.phone_number}",
      :body => "hello, #{user_find.first_name}. You have an appointment called: #{appointment_find.title} coming up. Please see CheckMark for details. Thank you, good bye."
)
  end
  
  
end

