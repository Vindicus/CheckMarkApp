require 'twilio-ruby'
class PhoneWorker
  include TwilioHelper
  include Sidekiq::Worker
  
  def perform(user,appointment)
    user_find=User.find(user)
    appointment_find=Appointment.find(appointment)
    appointment_title=appointment_find.title.gsub!(/\s+/,"%20")
       @call = @@Client.account.calls.create(
    :from => '+12096473083',
    :to => "+#{user_find.phone_number}",
    :url => "http://checkmark-vindicus.herokuapp.com/twilio/voice?title=#{appointment_title}",
)
  end
  
  

end


  