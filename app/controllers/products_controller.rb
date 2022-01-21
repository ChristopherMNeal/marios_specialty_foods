class ProductsController < ApplicationController
  before_action :only => [:new, :edit, :destroy] do
    if !current_user.admin
      flash[:alert] = "You are not authorized for this action."
    end
    redirect_to products_path unless current_user && current_user.admin
  end
  def index
    @products = Product.search(params[:search]).order(:name).page params[:page]
    @products_local = Product.local
    @products_featured = Product.featured
    render :index
  end
  
  def new
    @product = Product.new
    render :new
  end
  
  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "Spice successfully added!"
      redirect_to products_path
    else
      flash[:alert] = "There was an error in adding your Spice."
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    render :edit
  end
  
  def show
    @product = Product.find(params[:id])
    @average_review = Review.average_review
    render :show
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "Spice successfully updated!"
      redirect_to products_path
    else
      flash[:alert] = "There was an error in updating your Spice!"
      render :edit
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      flash[:notice] = "Spice successfully deleted!"
      redirect_to products_path
    end
  end

  private
    def product_params
      params.require(:product).permit(:name, :country_of_origin, :cost, :featured, :search)
    end

end