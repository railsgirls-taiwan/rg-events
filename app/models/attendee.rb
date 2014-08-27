class Attendee < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  has_many :field_values
  accepts_nested_attributes_for :field_values
  has_many :fields, through: :form

  validate :check_required_fields

  after_initialize do
    field_values.each do |field_value|
      self.class.send :define_method, field_value.field.name do
        field_value.value
      end
    end
  end

  def check_required_fields
    field_values.each do |field_value|
      if field_value.field.required && field_value.value.blank?
        errors.add(field_value.field.name, :blank)
      end
    end
  end
end
