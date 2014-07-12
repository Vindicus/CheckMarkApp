require 'rails_helper'

describe 'Appointments' do
  context 'manage appointments' do
    xit 'should successfully add the new appointment to the list' do
      visit '/appointments/new'
      within("#new_appointment") do
        fill_in 'appointment_title', with: 'Birthday'
        fill_in 'Location', with: 'my houose'
        fill_in 'Description', with: '18th birthday'
        select '2014-07-07', :from => 'Date'
        select '23:29:00', :from => 'Time'
        fill_in 'Friend email', with: '123@123.com'
      end
      click_button "Create Appointment"
      expect(page).to have_content 'You successfully created your appointment'
    end

  xit 'should delete an appointment' do
    appointment=FactoryGirl.build(:appointment, title: "birthday", description: "party", location: "home" ,date: "2013-06-07", time: "2000-01-01 09:33:00 UTC" )
    visit appointments_path
    within appointment.id.to_s do
      click_link 'Destroy'
    end
    expect(page).to have_content "You successfully deleted your appointment"
  end
  end
end