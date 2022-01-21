require 'rails_helper'

describe "the delete a review process" do
  before :each do
    user = User.create!({email: 'admin2@fake.com', password: 'f4k3p455w0rd', admin: true})
    login_as(user, :scope => :user)
    product = Product.create!({name: 'the essence', country_of_origin: 'Arrakis', cost: '998'})
    Review.create!({author: "Muad'dib", content_body: "Bless the Maker and His water. Bless the coming and going of Him. May His passage cleanse the world. May He keep the world for His people.", rating: 5, product_id: product.id})
  end
  
  it "deletes a review" do
    visit products_path
    click_link 'The Essence (Arrakis) - ☼998.00'
    click_link "Muad'dib - 5 stars"
    click_on 'Delete review'
    expect(page).to have_no_content "Muad'dib - 5 stars"
  end
end

describe "the delete a review process" do
  before :each do
    user = User.create!({email: 'user2@fake.com', password: 'f4k3p455w0rd', admin: false})
    login_as(user, :scope => :user)
    product = Product.create!({name: 'the essence', country_of_origin: 'Arrakis', cost: '998'})
    Review.create!({author: "Muad'dib", content_body: "Bless the Maker and His water. Bless the coming and going of Him. May His passage cleanse the world. May He keep the world for His people.", rating: 5, product_id: product.id})
    visit products_path
  end
  
  it "deletes a review" do
    click_link 'The Essence (Arrakis) - ☼998.00'
    click_link "Muad'dib - 5 stars"
    expect(page).to have_no_content 'Delete review'
  end
end