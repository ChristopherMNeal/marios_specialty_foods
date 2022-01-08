require 'rails_helper'

describe "the add an review process" do
  before :each do
    visit root_path
    click_link 'Add new Spice'
    fill_in 'Product', :with => 'the essence'
    fill_in 'Planet of Origin', :with => 'Arrakis'
    fill_in 'Cost in Imperial Solari ☼', :with => '998'
    click_on 'Create Product'
  end

  it "adds a new review" do
    click_link 'The Essence (Arrakis) - ☼998.0'
    click_link 'Add a review'
    fill_in 'Your Name', :with => "Muad'dib"
    fill_in 'Review', :with => "Bless the Maker and His water. Bless the coming and going of Him. May His passage cleanse the world. May He keep the world for His people."
    fill_in 'Your Rating', :with => 5.to_i
    click_on 'Create Review'
    expect(page).to have_content 'Review successfully added!'
    expect(page).to have_content "Muad'dib - 5 stars"
  end

  it "gives an error when no name is entered" do
    # visit products_path
    click_link 'The Essence (Arrakis) - ☼998.0'
    click_link 'Add a review'
    click_on 'Create Review'
    expect(page).to have_content 'There was an error in creating your review!'
  end
end
