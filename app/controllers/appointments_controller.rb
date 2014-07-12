class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @user_appointments=current_user.appointments.order(created_at: :desc).limit(10)
    @appointment=Appointment.joins(:invitations).where('invitations.invite_email' => current_user.email)

  end

  def new
    @appointment=Appointment.new
    @appointment.invitations.build
  end
  
  def create
    @appointment=current_user.appointments.new(appointment_params)
    if invite_success? && @appointment.save
        flash[:success] = "You successfully created your appointment"
        redirect_to action: :index
    else
        flash[:error] = "Your appointment was not saved"
        render "new"
  end
  end
  
     def edit
    @edit_appointment=Appointment.find(params[:id])
    @edit_appointment.invitations.build
  end
  
   def update
    @edit_appointment=Appointment.find(params[:id])
    if @edit_appointment.update(appointment_params)
      #Modify After Update
      @edit_appointment.invitations.each do |invite|
        email_downcase=invite.invite_email.downcase
         if User.email_exist(email_downcase) && email_downcase != current_user.email || invite.invite_email.downcase === 'delete'
           invite.update_attributes(user_id: current_user.id)
      else
        Invitation.where(invite_email: invite.invite_email).destroy_all
           flash[:emailerror]="Your friend's email is not associated with CheckMark and make sure not to place your email in the friend's list."
        return render 'edit'
   end
    end
      
      flash[:success] = "You successfully updated your appointment"
      return redirect_to action: :index
    else
       flash[:error] = "Your appointment was not saved"
      render "edit"
    end
  end
  
  def destroy
    if Appointment.destroy(params[:id])
     flash[:success] = "You successfully deleted your appointment"
    redirect_to action: :index
   else
     flash[:error] = "There was a problem deleting your appointment"
    redirect_to action: :index
   end
  end
  
  def accept_invite
    @accept=Invitation.find(params[:id])
    if @accept.update_attributes(accept: 't')
      flash[:success] = "Appointment accepted"
      redirect_to action: :index
    end
  end
  
  def decline_invite
     @accept=Invitation.find(params[:id])
    if @accept.update_attributes(accept: 'f')
      flash[:error] = "Appointment declined"
      redirect_to action: :index
    end
  end
  
  private
  def appointment_params
    params.require(:appointment).permit(:title,:description,:location,:date,:time, invitations_attributes:[:id,:invite_email,:accept, :_destroy])
end
  
  #method for Create
  def invite_success?
    bool_check=true
    @appointment.invitations.each do |invite|
      email_downcase=invite.invite_email.downcase
      if email_downcase != current_user.email
          if User.email_exist(email_downcase)
              invite.user_id=current_user.id
          else
              flash[:emailerror]="our friend's email is not associated with CheckMark and make sure not to place your email in the friend's list."
               bool_check=false
          end
     else
       flash[:emailerror]="You cannot add your own email into the list"
        bool_check=false
     end
    end
      bool_check
  end
  
end
