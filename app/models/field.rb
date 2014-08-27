class Field < ActiveRecord::Base
  extend Enumerize
  self.inheritance_column = nil

  belongs_to :event
  has_many :field_values

  enumerize :type, in: %i[text textarea checkbox select]

  def option_items= obj
    obj = obj.split(',') if obj.is_a? String
    super obj
  end

  def value_of(attendee)
    field_values.find_by(attendee: attendee)
  end
end
