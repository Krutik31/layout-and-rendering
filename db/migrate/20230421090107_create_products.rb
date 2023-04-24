class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.bigint :price
      t.string :capacity
      t.boolean :is_active
      t.integer :product_status

      t.timestamps
    end
  end
end
