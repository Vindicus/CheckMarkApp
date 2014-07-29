require 'twilio-ruby'
class PhoneWorker
  include Sidekiq::Worker
  
  def perform(user,appointment)
    account_sid = ENV['ACCOUNT_SID']
    auth_token = ENV['AUTH_TOKEN']
    @client = Twilio::REST::Client.new account_sid, auth_token
    user_find=User.find(user)
    appointment_find=Appointment.find(appointment)
    appointment_title=appointment_find.title.gsub!(/\s+/,"%20")
       @call = @client.account.calls.create(
    :from => '+12096473083',
    :to => "+#{user_find.phone_number}",
         :url => "http://www.todo-122362.usw1-2.nitrousbox.com/twilio/voice?title=#{appointment_title}",
)
  end
  
  

end


  