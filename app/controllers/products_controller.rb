class ProductsController < ApplicationController
  before_action :authenticate_user!

  layout 'merchant'

  def index
    @products = Product.all.order(id: :asc)
  end

  def show
    @product = Product.find(params[:id])
  end
end
