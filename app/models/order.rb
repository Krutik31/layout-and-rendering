class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user

  before_save :total_price

  private

  def total_price
    product = Product.find(product_id)
    self.total_amount = quantity * product.price
  end
end
