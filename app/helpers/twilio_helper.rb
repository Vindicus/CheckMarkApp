module TwilioHelper
  account_sid = ENV['ACCOUNT_SID']
  auth_token = ENV['AUTH_TOKEN']
  
  #Sets up the authentication for Twilio
  @@Client = Twilio::REST::Client.new account_sid, auth_token
end


