module Webhookable
extend ActiveSupport::Concern

  # Used for Twilio phone calls, creates a response 
  def set_header
    response.headers["Content-Type"] = "text/xml"
  end

  #renders a TWiML response text
  def render_twiml(response)
    render text: response.text
  end
end
