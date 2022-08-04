# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "faker"

puts "Seeding..."

address = ["10 chesham road, london KT1 3AQ", "52 Sinclair Road, london W14 0NH", "63 Ashurst road, london EN4 9LH"]
genre = ["abstract", "architecture", "landscape", "seascape", "portrait", "still life", "animals"]

10.times do
  user = User.create(
    { email: Faker::Internet.email,
      address: address.sample,
      password: "123456"
    }
    )
  user.save
end

10.times do
  art = ArtPiece.new(
   {
     name: Faker::GreekPhilosophers.name,
     user_id: rand(1..10),
     description: Faker::GreekPhilosophers.quote,
     genre: genre.sample,
     cost_per_day: Faker::Commerce.price
   }
)

photo = "#{genre.sample}.jpg"
art.photos.attach(io: File.open("db/photos/#{photo}"), filename: photo)
art.save
end

10.times do
 booking = Booking.create(
  {
    start_date: Faker::Date.in_date_period,
    end_date:Faker::Date.in_date_period
  }
)


puts "Seeding done."
