require "rails_helper"

describe ReminderMailer do
  it "should send reminders" do
    email = ReminderMailer.create_invite('do-not-reply@checkmark.com',
    'flme16@gmail.com.com', Time.now).deliver
    
    expect(email).not_to be(ActionMailer::Base.deliveries.empty?)
    expect(email).to eq(['do-not-reply@checkmark.com'], email.from)
    expect(email).to eq(['flme16@gmail.com'], email.to)
    expect(email).to eq("Your appointment reminder",email.subject)
    expect(email).to eq('You opted in to receive this reminder email for this appointment: Dentist Appointment.',email.body.to_s)
  end
end
