class Appointment < ActiveRecord::Base
  belongs_to :user
  has_many :invitations, :dependent => :destroy
  accepts_nested_attributes_for :invitations, reject_if: proc { |attributes| attributes[:invite_email].blank? }, allow_destroy: true
  validates :title, :location, :date, :time, presence: true
  validates_uniqueness_of :title, :scope => [:location, :description, :time, :date], message: "This exact appointment already exists"
end
