class Admin::Event < Event
  has_many :attendees
  has_many :fields
end
