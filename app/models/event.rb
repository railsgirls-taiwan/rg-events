class Event < ActiveRecord::Base
  include Select2Concern
  select2_white_list :title

  has_many :attendees
  has_many :fields
  accepts_nested_attributes_for :fields

  validate :end_after_start
  validates :title, :start_date, :end_date, :description, :presence => true


  private

  def end_after_start
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
