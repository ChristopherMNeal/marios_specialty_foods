require 'rails_helper'

describe Product do
  it { should have_many(:reviews) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :country_of_origin }
  it { should validate_presence_of :cost }
  it("titleizes the name of an product") do
    product = Product.create({name: "melange (aka the spice)", country_of_origin: "arrakis", cost: 9999})
    expect(product.name()).to(eq("Melange (Aka The Spice)"))
  end
end