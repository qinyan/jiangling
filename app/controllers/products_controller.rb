class ProductsController < ApplicationController
  
  skip_before_filter :require_login
  def index
    @products = Product.paginate page: params[:page]||1, per_page: 10
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    redirect_to product_path(@product) if @product.save
  end

  def show
    @product = Product.find(params[:id])
  end

  def update
  end

  def edit
  end

  def destroy
  end
  
end