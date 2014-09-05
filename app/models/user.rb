class User < ActiveRecord::Base
  include Select2Concern
  select2_white_list :email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :attendees

  validates :name, :email, :password, :presence => true
  validates :password, confirmation: true
  validates :name, :email, :uniqueness => true
  validates :email, format: {with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i}
  validates :tel, numericality: { only_integer: true}


  def is_admin?
    self.admin == true
  end
end
