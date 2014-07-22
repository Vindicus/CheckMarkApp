class Appointment < ActiveRecord::Base
  
  belongs_to :user
  has_many :invitations, :dependent => :destroy
  has_many :reminders
  accepts_nested_attributes_for :invitations, reject_if: proc { |attributes| attributes[:invite_email].blank? }, allow_destroy: true
  accepts_nested_attributes_for :reminders
  validates :title, :location, :date, :time, presence: true
  validates_uniqueness_of :title, :scope => [:location, :description, :time, :date], message: "This exact appointment already exists"
    
    def set_reminder
      ReminderWorker.perform_async(self.user_id, self.title)
    end
end
