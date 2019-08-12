class Product < ApplicationRecord
  belongs_to :product_category
  has_many :product_variations, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.manage_list(params)
    @products = Product.includes(:product_variations).distinct
    if params[:product_category_id].present?
      @products = @products.where(product_category_id: params[:product_category_id])
    else
      @products = @products.all
    end
    if params[:search].present?
      search = "%#{params[:search]}%"
      @products = @products.where("products.name ILIKE ? OR product_variations.variation_name ILIKE ? OR product_variations.color ILIKE ? OR product_variations.size ILIKE ?", search, search, search, search)
    end
    return @products
  end
end
