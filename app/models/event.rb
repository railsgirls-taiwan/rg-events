class Event < ActiveRecord::Base
  include Select2Concern
  select2_white_list :title

  has_many :attendees
  has_many :fields
  accepts_nested_attributes_for :fields

  validates_datetime :end_date, :after => :start_date
  validates :title, :start_date, :end_date, :description, :presence => true

  private

end
