# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts 'Cleaning database...'

Booking.destroy_all
Offer.destroy_all
User.destroy_all

puts 'Database cleaned'

# Create 5 users
puts 'Creating users'
require 'open-uri'

index = 0
5.times do
  user = User.new(
    email: Faker::Internet.email,
    password: 'password', # Assuming all users have the same password for simplicity
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
  # Generate and attach avatar image to the user
  avatar_url = "https://source.unsplash.com/featured/?portrait"
  user.avatar.attach(io: URI.open(avatar_url), filename: 'avatar.png')

  user.save!
  index += 1
  puts "user n°#{index}/5 created"
end

puts 'Users created'

# Create Offers on 2 users
puts 'Creating offers'
users = User.order('RANDOM()')
index = 0
offer_index = 0
2.times do
  # pick the first user from the randomised list of user then the second one
  user = users[index]
  20.times do
    offer = user.offers.new(
      name: Faker::Commerce.product_name,
      category: CATEGORIES.sample,
      pick_up_from: Faker::Time.between(from: DateTime.now, to: DateTime.now + 30),
      pick_up_till: Faker::Time.between(from: DateTime.now + 31, to: DateTime.now + 60),
      return_from: Faker::Time.between(from: DateTime.now + 61, to: DateTime.now + 90),
      return_till: Faker::Time.between(from: DateTime.now + 91, to: DateTime.now + 120),
      country: Faker::Address.country,
      state: Faker::Address.state,
      city: Faker::Address.city,
      postcode: Faker::Address.postcode,
      address_1: Faker::Address.street_address,
      address_2: Faker::Address.secondary_address,
      description: Faker::Lorem.paragraph,
      available: true,
      price_per_day: Faker::Number.decimal(l_digits: 2)
    )
    photo_url = "https://source.unsplash.com/featured/?camping&#{offer.category}"
    offer.photos.attach(io: URI.open(photo_url), filename: 'photo.png')
    offer.save!
    offer_index += 1
    puts "Offer n°#{offer_index}/#{2*20} created"
  end
  index += 1
end
puts 'Offers created'

puts 'Creating bookings'
# Create bookings requested by 3 other users
1000.times do
  # Randomly select a user who hasn't created an offer
  user = User.where.not(id: Offer.pluck(:user_id)).sample
  # Randomly select an offer
  offer = Offer.all.sample
  booking = Booking.create!(
    user: user,
    offer: offer,
    from: Faker::Date.between(from: Date.today + 10, to: Date.today + 20),
    to: Faker::Date.between(from: Date.today + 21, to: Date.today + 30),
    # Assuming we use these 3 statuses
    status: STATUSES.sample
  )
end

# Create bookings from an owner
3.times do
  # Randomly select a user who hasn't created an offer
  user = User.where(id: Offer.pluck(:user_id)).sample
  # Randomly select an offer
  offer = Offer.all.sample
  booking = Booking.create!(
    user: user,
    offer: offer,
    from: Faker::Date.between(from: Date.today + 10, to: Date.today + 20),
    to: Faker::Date.between(from: Date.today + 21, to: Date.today + 30),
    # Assuming we use these 3 statuses
    status: STATUSES.sample
  )
end
