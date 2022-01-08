require 'rails_helper'

describe "the delete a product process" do
  before :each do
    visit root_path
    click_link 'Add new Spice'
    fill_in 'Product', :with => 'the essence'
    fill_in 'Planet of Origin', :with => 'Arrakis'
    fill_in 'Cost in Imperial Solari ☼', :with => '998'
    click_on 'Create Product'
  end
  it "deletes a product" do
    click_link 'The Essence (Arrakis) - ☼998.0'
    click_on 'Delete spice'
    expect(page).to have_no_content 'The Essence (Arrakis) - ☼998.0'
  end

end
