class FieldValue < ActiveRecord::Base
  belongs_to :field
  belongs_to :attendee

  def value= value
    value = value.to_json if value.is_a? Array
    super value
  end

  def value
    field.multiple ? JSON.parse(read_attribute(:value)) : super rescue super
  end

  def value_text
    field.multiple ? JSON.parse(value) : value rescue value
  end
end
