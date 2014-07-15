require 'rails_helper'

describe Invitation do
  
 xit "is invalid if a duplicate is found" do
    FactoryGirl.create(:invitation, invite_email: "test1@test.com")
    subject {FactoryGirl.build(:invitation, invite_email: "test1@test.com" )}
    
    expect(subject).to_not be_valid
  end
end