class Event < ActiveRecord::Base
  include Select2Concern
  select2_white_list :title

  has_many :attendees
  has_many :fields
  accepts_nested_attributes_for :fields
end
