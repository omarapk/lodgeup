# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require"date"
require "open-uri"
require "open-uri"

puts "Cleaning flats..."
Flat.destroy_all

puts "Creating flats for user with ID 4..."

user = User.find(4)

image_url = "https://images.unsplash.com/photo-1600585154340-be6161a56a0c"

flats = [
  { title: "Sunny Apartment", description: "Bright and cozy apartment near the beach.", location: "Barcelona", price: 120, availability_start: Date.today, availibility_end: Date.today + 30 },
  { title: "Mountain View Studio", description: "Quiet studio with an amazing view.", location: "Chamonix", price: 100, availability_start: Date.today, availibility_end: Date.today + 15 },
  { title: "Central Loft", description: "Modern loft in the city center.", location: "Berlin", price: 150, availability_start: Date.today + 3, availibility_end: Date.today + 20 },
  { title: "Rustic Cabin", description: "Perfect escape in the woods.", location: "Trentino", price: 90, availability_start: Date.today + 5, availibility_end: Date.today + 25 }
]

flats.each do |flat_data|
  flat = Flat.new(flat_data)
  flat.user = user
  file = URI.open(image_url)
  flat.photo.attach(io: file, filename: "flat.jpg", content_type: "image/jpg")
  flat.save!
end

puts "✅ Flats created!"
