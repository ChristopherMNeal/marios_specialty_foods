class ProductsController < ApplicationController

  def index
    @products = Product.all
    @products_local = Product.local
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
    @product.destroy
    redirect_to products_path
  end

  private
    def product_params
      params.require(:product).permit(:name, :country_of_origin, :cost)
    end

end