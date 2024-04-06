class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :offer

  before_validation :set_default_status, on: :create
  validate :to_date_after_from_date
  private

  def to_date_after_from_date
    return if to.blank? || from.blank?
    if to < from
      errors.add(:to, "date must be after or equal to the from date")
    end
  end

  def set_default_status
    self.status ||= "pending"
  end
end
