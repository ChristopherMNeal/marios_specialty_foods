require 'rails_helper'

describe "the edit a review process" do
  before :each do
    user = User.create!({email: 'admin2@fake.com', password: 'f4k3p455w0rd', admin: true})
    login_as(user, :scope => :user)
    product = Product.create!({name: 'the essence', country_of_origin: 'Arrakis', cost: '998'})
    Review.create!({author: "Muad'dib", content_body: "Bless the Maker and His water. Bless the coming and going of Him. May His passage cleanse the world. May He keep the world for His people.", rating: 5, product_id: product.id})
    visit products_path
    click_link 'The Essence (Arrakis) - ☼998.00'
    click_link "Muad'dib - 5 stars"
    click_link 'Edit review'
  end

  it "edits a review" do
    fill_in 'Your Name', :with => 'Usul'
    click_on 'Update Review'
    expect(page).to have_content 'Usul - 5 stars'
    expect(page).to have_content 'Review successfully updated!'
    expect(page).to have_no_content "Muad'dib - 5 stars"
  end

  it "gives an error when a field is missing" do
    fill_in 'Your Rating', :with => '6'
    fill_in 'Your Name', :with => ''
    click_on 'Update Review'
    expect(page).to have_content 'Rating must be less than 6'
    expect(page).to have_content "Author can't be blank"
    expect(page).to have_content 'There was an error in updating your review!'
  end
end

describe "the unauthorized to edit a product if not admin process" do
  before :each do
    user = User.create!({email: 'user2@fake.com', password: 'f4k3p455w0rd', admin: false})
    login_as(user, :scope => :user)
  end
  
  it "fails to edit a review" do
    product = Product.create!({name: 'the essence', country_of_origin: 'Arrakis', cost: '998'})
    review = Review.create!({author: "Muad'dib", content_body: "Bless the Maker and His water. Bless the coming and going of Him. May His passage cleanse the world. May He keep the world for His people.", rating: 5, product_id: product.id})
    visit edit_product_review_path(product, review)
    expect(page).to have_content 'You are not authorized for this action.'
  end
end