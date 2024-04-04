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
5.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: 'password', # Assuming all users have the same password for simplicity
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end
