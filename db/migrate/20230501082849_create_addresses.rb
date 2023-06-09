class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :house_name
      t.string :street_name
      t.string :road
      t.belongs_to :employee, index: true, foreign_key: true

      t.timestamps
    end
  end
end
