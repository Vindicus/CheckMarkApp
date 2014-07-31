require 'twilio-ruby'
class TwilioController < ApplicationController
  include Webhookable
  after_filter :set_header
  skip_before_action :verify_authenticity_token
  
  #Prompts the Twilio call to render a response based on this response
  def voice
    title=params[:title]
    
    response = Twilio::TwiML::Response.new do |r|
      r.Say "Hello, you have an appointment called #{title}. Please see CheckMark for details", :voice => 'alice'  
    end
    
    render_twiml response
  end
end
