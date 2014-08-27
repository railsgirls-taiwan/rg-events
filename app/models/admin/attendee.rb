class Admin::Attendee < Attendee
  belongs_to :user
  belongs_to :event
end
