class Invitation < ActiveRecord::Base
  before_update :remove_deletes
  belongs_to :user
  belongs_to :appointment
  

  private
  
  #PATCH to allow attendees to accept an invitation
  def self.accept_invite(accept,current_user)
    if accept.update_attributes(accept: 't')
      Appointment.joins(:invitations).find_by("invitations.id"=> accept.id).reminders.find_or_create_by(:user_id => current_user.id) do |reminder|
        reminder.email_accept = true
        reminder.phone_number_accept = false
        reminder.phone_sms_accept = false
      end
    end
  end

  #if a delete string appears in the database, destroy it
  def remove_deletes
    Invitation.where(invite_email: 'delete').destroy_all
    Invitation.where(invite_email: 'DELETE').destroy_all
  end
end
