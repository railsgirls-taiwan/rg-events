class Attendee < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  has_many :field_values
  has_many :fields, through: :form
end
