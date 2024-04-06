class Offer < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photos
  validates :photos, attached: true, content_type: [:png, :jpg, :jpeg]
  validates :category, inclusion: {
    in: CATEGORIES,
    message: "must be one of #{CATEGORIES[0..-2].join(", ") + " or " + CATEGORIES[-1]}"
  }
end
