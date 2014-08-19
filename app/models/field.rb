class Field < ActiveRecord::Base
  belongs_to :event
  has_many :field_values
end
