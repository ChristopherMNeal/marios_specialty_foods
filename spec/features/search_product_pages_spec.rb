require 'rails_helper'

describe "the search for a product process" do
  before :each do
    user = User.create!({email: 'admin2@fake.com', password: 'f4k3p455w0rd', admin: true})
    login_as(user, :scope => :user)
    product = Product.create!({name: 'the essence', country_of_origin: 'Arrakis', cost: '998'})
    product = Product.create!({name: 'garlic powder', country_of_origin: 'ix', cost: '2'})
    visit products_path
  end
  it "searches for a product" do
    fill_in 'Search for a spice:', :with => 'essence'
    click_on 'Search'
    expect(page).to have_no_content 'Garlic Powder'
    expect(page).to have_content 'The Essence'

  end
end