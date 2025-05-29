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
User.create(email:"test@gmail.com", password:"123456", username:"test")
Flat.create(title:"test",description:'test', location:"test",price:100, availability_start: Date.today, availibility_end:Date.tomorrow, user_id:1)
Booking.create(check_in:Date.today,check_out:Date.tomorrow,status:false,user_id:1,flat_id:1)