class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :first_name, :last_name, presence: true
  validates :phone_number, presence: true, format:{with: /[0-9]{3}-[0-9]{3}-[0-9]{4}/,
    message: "Your phone number must be in xxx-xxx-xxxx format."  }
  
end
