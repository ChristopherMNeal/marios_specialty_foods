require 'rails_helper'

describe "the add a review process" do
  before :each do
    user = User.create!({email: 'admin2@fake.com', password: 'f4k3p455w0rd', admin: true})
    login_as(user, :scope => :user)
    Product.create!({name: 'the essence', country_of_origin: 'Arrakis', cost: '998'})
    visit products_path
    click_link 'The Essence (Arrakis) - ☼998.0'
    click_link 'Add a review'
  end

  it "adds a new review" do
    fill_in 'Your Name', :with => "Muad'dib"
    fill_in 'Review', :with => "Bless the Maker and His water. Bless the coming and going of Him. May His passage cleanse the world. May He keep the world for His people."
    fill_in 'Your Rating', :with => 5
    click_on 'Create Review'
    expect(page).to have_content 'Review successfully added!'
    expect(page).to have_content "Muad'dib - 5 stars"
  end

  it "gives an error when no name is entered" do
    click_on 'Create Review'
    expect(page).to have_content 'There was an error in creating your review!'
  end
end
