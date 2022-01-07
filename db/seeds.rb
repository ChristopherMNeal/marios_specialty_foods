# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.destroy_all

20.times do |index|
  product = Product.create!({name: Faker::Food.unique.spice,
    country_of_origin: Faker::Books::Dune.city,
    cost: rand(3..99)})
  rand(3..11).times do |index|
    Review.create!({author: Faker::Books::Dune.character, 
      content_body: Faker::Books::Dune.quote,
      rating: rand(1..5),
      product_id: product.id})
  end
end

p "Created #{Product.count} products"
p "Created #{Review.count} products"
