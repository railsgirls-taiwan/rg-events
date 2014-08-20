class Admin::User < User
  has_many :attendees
end
