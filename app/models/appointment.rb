class Appointment < ActiveRecord::Base
  belongs_to :user
  #validates :title, :date, :time, presence: true
end
