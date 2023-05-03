class Employee < ApplicationRecord
  mount_uploader :document, DocumentUploader

  has_and_belongs_to_many :hobbies, dependent: :destroy
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses
end
