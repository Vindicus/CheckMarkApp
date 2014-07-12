require 'rails_helper'

describe Appointment do
  it "is invalid without a title" do
    title=FactoryGirl.build(:appointment, :title => nil).valid?
    expect(title).to be_falsy
  end
  it "is invalid without a location" do
    location=FactoryGirl.build(:appointment, :location => nil).valid?
    expect(location).to be_falsy
  end
 
  
  it "is invalid if a duplicate is found" do
    FactoryGirl.create(:appointment, title: "birthday", description: "party", location: "home" ,date: "2013-06-07", time: "2000-01-01 09:33:00 UTC" )
    subject {FactoryGirl.build(:appointment, title: "birthday", description: "party", location: "home" ,date: "2013-06-07", time: "2000-01-01 09:33:00 UTC" )}
    
    expect(subject).to_not be_valid
  end
end