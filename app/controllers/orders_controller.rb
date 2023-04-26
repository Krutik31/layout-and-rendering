class OrdersController < ApplicationController
  before_action :authenticate_userrole, except: :index
  before_action :authenticate_user!

  layout :order_layout

  def index
    @orders = is_admin? ? Order.all : current_user.orders
  end

  def new
    @order = Order.new
    @product = Product.find(params[:product_id])
  end

  def create
    user = User.find(current_user.id)
    @order = user.orders.new(order_params)

    if @order.save
      redirect_to orders_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def authenticate_userrole
    redirect_to '/' unless current_user&.Merchant?
  end

  def order_layout
    is_admin? ? 'admin' : 'merchant'
  end

  def is_admin?
    current_user&.Admin?
  end

  def order_params
    @order_params = params.require(:order).permit(:quantity, :order_status, :product_id)
  end
end
