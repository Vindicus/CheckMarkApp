class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :first_name, :last_name, presence: true
  validates :phone_number, presence: true
  
  has_many :appointments
  has_many :invitations
  has_many :reminders
   def self.email_exist(email)
   self.exists?(:email => email)
  end
end
