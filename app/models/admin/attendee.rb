class Admin::Attendee < Attendee
  belongs_to :user
  belongs_to :form
end
