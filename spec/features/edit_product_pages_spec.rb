require 'rails_helper'

describe "the edit a product process" do
  before :each do
    user = User.create!({email: 'admin2@fake.com', password: 'f4k3p455w0rd', admin: true})
    login_as(user, :scope => :user)
    product = Product.create!({name: 'the essence', country_of_origin: 'Arrakis', cost: '998'})
    visit products_path
    click_link 'The Essence (Arrakis) - ☼998.0'
    click_link 'Edit'
  end

  it "edits a product" do
    fill_in 'Product', :with => 'Spice'
    click_on 'Update Product'
    expect(page).to have_content 'Spice (Arrakis) - ☼998.0'
    expect(page).to have_no_content 'The Essence'
  end

  it "gives an error when a field is missing" do
    fill_in 'Product', :with => ''
    click_on 'Update Product'
    expect(page).to have_content 'There was an error in updating your Spice!'
  end
end

describe "the unauthorized to edit a product if not admin process" do
  before :each do
    user = User.create!({email: 'user2@fake.com', password: 'f4k3p455w0rd', admin: false})
    login_as(user, :scope => :user)
    @product = Product.create!({name: 'the essence', country_of_origin: 'Arrakis', cost: '998'})
  end
  
  it "fails to edits a new product" do
    visit edit_product_path(@product)
    expect(page).to have_content 'You are not authorized for this action.'
  end
end