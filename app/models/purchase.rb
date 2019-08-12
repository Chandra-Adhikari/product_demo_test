class Purchase < ApplicationRecord
  belongs_to :product
  belongs_to :product_variation, optional: true
end
