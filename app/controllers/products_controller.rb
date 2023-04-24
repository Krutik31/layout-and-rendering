class ProductsController < ApplicationController
  layout 'merchant'

  def index
    @products = Product.all.order(id: :asc)
  end

  def show
    @product = Product.find(params[:id])
  end
end
