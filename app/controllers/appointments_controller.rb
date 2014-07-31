class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  
  #Displays the appointments for both invited and personal appointments
  def index
    @user_appointments=current_user.appointments.order(created_at: :desc)
    @invited_appointment=Appointment.joins(:invitations).where('invitations.invite_email' => current_user.email)
  end

  #Allow users to create an appointment
  def new
    @appointment=Appointment.new
    @appointment.reminders.build
    @appointment.invitations.build
  end
  
  #Parameters are sent and enters data into its respective model tables
  def create
    @appointment=current_user.appointments.new(appointment_params)
    
    if Appointment.invite_success?(@appointment,current_user) && @appointment.save
      #Sets the time for reminders
      Appointment.set_reminder(current_user.id,@appointment.id)
      
      flash[:success] = "You successfully created your appointment"
      redirect_to action: :index
    else
      flash[:emailerror]="If you are inviting others, double check that the email is associated with CheckMark and your own email is not included in the list"
      flash[:error] = "Your appointment was not saved"
      
      @appointment.invitations.build if @appointment.invitations.blank?
      
      render "new"
    end
  end
  
  #Allow users to edit their personal appointments
  def edit
    @edit_appointment=Appointment.find(params[:id])
    @edit_appointment.invitations.build
  end
  
   #Parameters are sent and updated
   def update
     @edit_appointment=Appointment.find(params[:id])
     
      if @edit_appointment.update(appointment_params)
        if !Appointment.update_success?(@edit_appointment,current_user)
        flash[:emailerror]="Your friend's email is not associated with CheckMark and make sure not to place your email in the friend's list."
        return redirect_to  action: :edit
        end
        #Sets the time for reminders
        Appointment.set_reminder(current_user.id,@edit_appointment.id)
        
        flash[:success] = "You successfully updated your appointment"
        return redirect_to action: :index
      else
       flash[:error] = "Your appointment was not saved"
       
        @edit_appointment.invitations.build if @edit_appointment.invitations.blank?
        
        render "edit"
      end
  end
  
  #Delete and appointment and prompts user, "Are you sure?"
  def destroy
    if Appointment.destroy(params[:id])
      flash[:success] = "You successfully deleted your appointment"
      redirect_to action: :index
    else
      flash[:error] = "There was a problem deleting your appointment"
      redirect_to action: :index
    end
  end
  
  #PATCH to allow attendees to accept an invitation
  def accept_invite
    @accept=Invitation.find(params[:id])
    
    #accepts invitation and updates invitation to True
    Invitation.accept_invite(@accept,current_user)
    
    #Sets the time for reminders
    Appointment.set_reminder(current_user.id,@accept.appointment_id)
    
    flash[:success] = "Appointment accepted"
    redirect_to action: :index
  end
  


  private
  
  def appointment_params
    params.require(:appointment).permit(:title,:description,:location,:time, invitations_attributes:[:id,:invite_email,:accept, :_destroy],
    reminders_attributes:[:id, :email_accept, :phone_number_accept, :phone_sms_accept, :appointment_id, :user_id, :_destroy])
  end
end
