class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 8, scale: 2
      t.decimal :discounted_price, precision: 8, scale: 2
      t.references :product_category, foreign_key: true

      t.timestamps
    end
    add_index :products, [:name]
  end
end
