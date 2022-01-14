# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.destroy_all
User.destroy_all

1.times do |index|
  user = User.create!({email: 'admin@fake.com', password: 'testing', admin: true})
end
1.times do |index|
  user = User.create!({email: 'user@fake.com', password: 'testing', admin: false})
end

melange = Product.create({ name: "Melange", country_of_origin: "Dune", cost: 998})
Review.create({ author: "Muad'Dib", content_body: "Bless the Maker and His water. Bless the coming and going of Him. May His passage cleanse the world. May He keep the world for His people.", rating: 5, product_id: melange.id})

49.times do |index|
  product = Product.create!({name: Faker::Food.spice,
    country_of_origin: Faker::Books::Dune.planet,
    cost: rand(3..99)})
  rand(4..12).times do |index|
    Review.create({author: Faker::Books::Dune.character,
      content_body: Faker::Books::Dune.quote,
      rating: rand(1..5),
      product_id: product.id})
  end
end

p "Created #{Product.count} products"
p "Created #{Review.count} reviews"
