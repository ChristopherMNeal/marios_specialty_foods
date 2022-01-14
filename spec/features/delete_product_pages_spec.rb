require 'rails_helper'

describe "the delete a product process" do
  before :each do
    user = User.create!({email: 'admin2@fake.com', password: 'f4k3p455w0rd', admin: true})
    login_as(user, :scope => :user)
    product = Product.create!({name: 'the essence', country_of_origin: 'Arrakis', cost: '998'})
    visit products_path
  end
  it "deletes a product" do
    click_link 'The Essence (Arrakis) - ☼998.0'
    click_on 'Delete spice'
    expect(page).to have_no_content 'The Essence (Arrakis) - ☼998.0'
  end
end

describe "the unauthorized to delete a product if not admin process" do
  before :each do
    user = User.create!({email: 'user2@fake.com', password: 'f4k3p455w0rd', admin: false})
    login_as(user, :scope => :user)
    @product = Product.create!({name: 'the essence', country_of_origin: 'Arrakis', cost: '998'})
  end
  
  it "fails to delete a product" do
    # page.driver.delete("/product/#{@product.id}")
    # expect(page).to have_content 'You are not authorized for this action.'
  end
end