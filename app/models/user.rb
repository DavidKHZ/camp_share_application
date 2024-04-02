class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :offers
  has_many :bookings
  has_many :provided_bookings, through: :offers, source: :bookings  # Bookings where the user is the provider
end
