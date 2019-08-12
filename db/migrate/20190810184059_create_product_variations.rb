class CreateProductVariations < ActiveRecord::Migration[5.2]
  def change
    create_table :product_variations do |t|
      t.string :variation_name
      t.string :size
      t.string :color
      t.decimal :price, precision: 8, scale: 2
      t.decimal :discounted_price, precision: 8, scale: 2
      t.boolean :availibility, default: true
      t.references :product, foreign_key: true

      t.timestamps
    end
    add_index :product_variations, :variation_name
    add_index :product_variations, :size
    add_index :product_variations, :color
    add_index :product_variations, :price
    add_index :product_variations, :availibility
  end
end
