class WelcomeController < ApplicationController
  def index
    @products = Product.all
    @reviews = Reviews.all
    @products_most_recent = Product.most_recent
    @products_most_reviews = Product.most_reviews
  end
end
