class Invitation < ActiveRecord::Base
  before_update :remove_deletes
  belongs_to :user
  belongs_to :appointment
  

  private
  def remove_deletes
    Invitation.where(invite_email: 'delete').destroy_all
     Invitation.where(invite_email: 'DELETE').destroy_all
    
  end
end
