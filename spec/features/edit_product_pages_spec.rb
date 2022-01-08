require 'rails_helper'

describe "the edit a product process" do
  before :each do
    visit root_path
    click_link 'Add new Spice'
    fill_in 'Product', :with => 'the essence'
    fill_in 'Planet of Origin', :with => 'Arrakis'
    fill_in 'Cost in Imperial Solari ☼', :with => '998'
    click_on 'Create Product'
  end

  it "edits a product" do
    click_link 'The Essence (Arrakis) - ☼998.0'
    click_link 'Edit'
    fill_in 'Product', :with => 'Spice'
    click_on 'Update Product'
    expect(page).to have_content 'Spice (Arrakis) - ☼998.0'
    expect(page).to have_no_content 'The Essence'
  end

  it "gives an error when a field is missing" do
    click_link 'The Essence (Arrakis) - ☼998.0'
    click_link 'Edit'
    fill_in 'Product', :with => ''
    click_on 'Update Product'
    expect(page).to have_content 'There was an error in updating your Spice!'

  end
end
