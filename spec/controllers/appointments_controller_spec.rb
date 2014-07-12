require 'rails_helper'

describe AppointmentsController do
 before (:each) do
  @user = User.create!({
    :first_name => "test",
    :last_name => "test",
    :phone_number => "000-000-0000",
    :email => 'user@test.com',
    :password => 'pleaseee',
    :password_confirmation => 'pleaseee'
    })
  sign_in @user
end
  describe "GET #index" do
    subject {get :index}
    it"should GET index action successfully" do
      expect(response.status).to eq(200)
    end
    it "should render GET #index view" do
      expect(subject).to render_template("index")
    end
    xit "populates user's appointments" do
      appointment=FactoryGirl.create(:appointment)
      get :index
      expect(assigns(:appointments)).to eq([appointment])
    end
    
  end
  describe "GET #new" do
    subject {get :new}
    it"should GET new action successfully" do
      expect(response.status).to eq(200)
    end
    it "should render GET #new view" do
      expect(subject).to render_template("new")
    end
  end
  describe "POST #create" do
    xit "creates a new appointment" do
      post :create
      expect{attributes_for(appointment)}.to change(Appointment,:count).by(1)
    end
  end
  describe "GET #edit" do
    it "should GET edit action successfully" do
      expect(response.status).to eq(200)
  end
  end
  describe "PATCH #update" do
    let(:appointment) {FactoryGirl.build(:appointment, :title => "Dentist")}
    xit "updates the appointment attributes" do
      patch :update, id: appointment
      appointment.reload
      expect(appointment.title).to equal("Dentist")
    end
  end
  describe "DELETE #destroy" do
    xit "deletes an appointment" do
      subject {FactoryGirl.create(:appointment, title: "birthday", description: "party", location: "home" ,date: "2013-06-07", time: "2000-01-01 09:33:00 UTC" )}
      expect{delete :destroy, id: subject}.to change(Appointment,:count).by(-1)
    end
  end
  
  
end