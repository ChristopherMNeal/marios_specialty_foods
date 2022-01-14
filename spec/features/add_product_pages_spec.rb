require 'rails_helper'

describe "the add a product process" do
  before :each do
    user = User.create!({email: 'admin2@fake.com', password: 'f4k3p455w0rd', admin: true})
    login_as(user, :scope => :user)
  end

  it "adds a new product" do
    visit root_path
    click_link 'Add new Spice'
    fill_in 'Product', :with => 'the essence'
    fill_in 'Planet of Origin', :with => 'Arrakis'
    fill_in 'Cost in Imperial Solari ☼', :with => '998'
    click_on 'Create Product'
    expect(page).to have_content 'Spice successfully added!'
    expect(page).to have_content 'The Essence (Arrakis) - ☼998.0'
  end

  it "gives an error when no name is entered" do
    visit new_product_path
    click_on 'Create Product'
    expect(page).to have_content "Name can't be blank"
  end
end

describe "the unauthorized to add a product if not admin process" do
  before :each do
    user = User.create!({email: 'user2@fake.com', password: 'f4k3p455w0rd', admin: false})
    login_as(user, :scope => :user)
  end
  
  it "fails to adds a new product" do
    visit new_product_path
    expect(page).to have_content 'You are not authorized for this action.'
  end
end