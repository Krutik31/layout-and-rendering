class Product < ApplicationRecord
  has_many :orders
  has_many :users, through: :orders

  validates :title, :description, :price, :capacity, presence: true
  validates :product_status, inclusion: { in: [0, 1, 2], message: 'Invalid.' }

  enum :status, ['In stock', 'Out of stock', 'Coming soon']
end
