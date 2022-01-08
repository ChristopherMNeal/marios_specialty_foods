require 'rails_helper'

describe "the edit a review process" do
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

  it "edits a review" do
    click_link "Muad'dib - 5 stars"
    click_link 'Edit review'
    fill_in 'Your Name', :with => 'Usul'
    click_on 'Update Review'
    expect(page).to have_content 'Usul - 5 stars'
    expect(page).to have_content 'Review successfully updated!'
    expect(page).to have_no_content "Muad'dib - 5 stars"
  end

  it "gives an error when a field is missing" do
    click_link "Muad'dib - 5 stars"
    click_link 'Edit review'
    fill_in 'Your Rating', :with => '6'
    fill_in 'Your Name', :with => ''
    click_on 'Update Review'
    expect(page).to have_content 'Rating must be less than 6'
    expect(page).to have_content "Author can't be blank"
    expect(page).to have_content 'There was an error in updating your review!'
  end
end
