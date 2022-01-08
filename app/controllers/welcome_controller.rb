class WelcomeController < ApplicationController
  def index
    @products = Product.all
    @products_most_recent = Product.most_recent
    @products_most_reviews = Product.most_reviews
    @products_local = Product.local
  end
end


