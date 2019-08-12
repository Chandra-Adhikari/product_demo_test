class ProductVariation < ApplicationRecord
  belongs_to :product
  has_many :images, as: :imageable, dependent: :destroy
  has_many :purchases, dependent: :destroy

end
