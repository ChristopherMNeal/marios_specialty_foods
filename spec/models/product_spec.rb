require 'rails_helper'

describe Product do
  it { should have_many(:reviews) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :country_of_origin }
  it { should validate_presence_of :cost }
  it { should validate_numericality_of(:cost).is_less_than_or_equal_to(999999.99) } 
  it { should validate_numericality_of(:cost).is_greater_than(0) } 
  it("titleizes the name of an product") do
    product = Product.create({name: "melange (aka the spice)", country_of_origin: "arrakis", cost: 9999})
    expect(product.name()).to(eq("Melange (Aka The Spice)"))
  end
end