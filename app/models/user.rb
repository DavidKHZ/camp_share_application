class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # , :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :offers
  has_many :bookings
  # Bookings where the user is the provider
  has_many :provided_bookings, through: :offers, source: :bookings
  has_one_attached :avatar

  # validates :avatar, attached: true, content_type: [:png, :jpg, :jpeg]
end
