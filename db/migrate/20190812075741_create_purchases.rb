class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.references :product, foreign_key: true
      t.references :product_variation, foreign_key: true
      t.string :quantity, default: 0
      t.string :total_amount, precision: 8, scale: 2

      t.timestamps
    end
  end
end
