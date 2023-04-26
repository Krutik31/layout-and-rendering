class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :users, through: :orders

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, %w[Admin Merchant]
end
