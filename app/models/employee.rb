class Employee < ApplicationRecord
  mount_uploader :document, DocumentUploader

  has_and_belongs_to_many :hobbies, dependent: :destroy
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses

  attr_accessor :hobbies_data

  after_create_commit :add_hobbies_data
  after_update_commit :update_hobbies_data

  def add_hobbies_data
    Employee.find(id).hobbies << Hobby.where(id: hobbies_data)
  end

  def update_hobbies_data
    Employee.find(id).hobbies.destroy(Hobby.all)
    add_hobbies_data
  end
end
