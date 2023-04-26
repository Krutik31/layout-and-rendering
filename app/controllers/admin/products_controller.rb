module Admin
  class ProductsController < ApplicationController
    layout 'admin'

    before_action :fetch_product, only: %i[show edit update destroy]
    before_action :check_userrole

    def index
      @products = Product.all.order(id: :asc)
    end

    def show; end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)

      if @product.save
        redirect_to admin_products_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @product.update(product_params)
        redirect_to admin_products_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @product.destroy

      redirect_to admin_products_path
    end

    private

    def fetch_product
      @product = Product.find(params[:id])
    end

    def check_userrole
      redirect_to '/' unless current_user&.Admin?
    end

    def product_params
      params.require(:product).permit(:title, :description, :price, :capacity, :is_active, :product_status)
    end
  end
end
