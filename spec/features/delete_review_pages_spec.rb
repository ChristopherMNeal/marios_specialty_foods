require 'rails_helper'

describe "the delete a review process" do
  before :each do
    visit root_path
    click_link 'Add new Spice'
    fill_in 'Product', :with => 'the essence'
    fill_in 'Planet of Origin', :with => 'Arrakis'
    fill_in 'Cost in Imperial Solari ☼', :with => '998'
    click_on 'Create Product'
    click_link 'The Essence (Arrakis) - ☼998.0'
    click_link 'Add a review'
    fill_in 'Your Name', :with => "Muad'dib"
    fill_in 'Review', :with => "Bless the Maker and His water. Bless the coming and going of Him. May His passage cleanse the world. May He keep the world for His people."
    fill_in 'Your Rating', :with => 5
    click_on 'Create Review'
  end
  
  it "deletes a review" do
    click_link "Muad'dib - 5 stars"
    click_on 'Delete review'
    expect(page).to have_no_content "Muad'dib - 5 stars"
  end

end