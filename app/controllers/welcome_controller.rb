class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  def index
    @products = Product.all
    @products_most_recent = Product.most_recent
    @products_most_reviews = Product.most_reviews
  end
end


