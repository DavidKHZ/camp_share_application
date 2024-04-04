class Offer < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photos
  validates :photos, attached: true, content_type: [:png, :jpg, :jpeg]
end
