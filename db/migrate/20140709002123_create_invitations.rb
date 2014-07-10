class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.belongs_to :appointment
      t.string :invite_email
      t.belongs_to :user
      
      t.timestamps
    end
  end
end