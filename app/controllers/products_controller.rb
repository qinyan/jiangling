class ProductsController < ApplicationController
  
  skip_before_filter :require_login
  before_filter :load_product, only: [:show, :update, :edit, :destroy]

  def index
    @products = Product.paginate page: params[:page]||1, per_page: 10
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def show
  end

  def update
    if @product.update_attributes(params[:product])
      redirect_to products_path
    else
      render :edit
    end
  end

  def edit
  end

  def destroy    
    redirect_to products_path  if @product.destroy
  end

  private

  def load_product
    @product = Product.find(params[:id])
  end
  
end