require 'will_paginate/array'
class V1::ProductsController < ApplicationController
  def index
    @products = Product.manage_list(params)
    if @product.present?
      @products = @products.map {|product| product.attributes.merge(product_variations: product.product_variations, product_category: product.product_category.try(:name), product_images: product.images.pluck(:content))} if @products.present?
      @products = @products.paginate(page: params[:page], per_page: 50) if @products.present?
      render(json: { message: 'Product list fetched successfully.', products: @products}, status: 200)
    else
      render(json: { message: 'No product found.'}, status: 500)
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
    if @product.present?
      @product_variants = @product.product_variations
      @product_variants = @product_variants.where("product_variations.variation_name ILIKE ? OR product_variations.color ILIKE ? OR product_variations.size ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
      render(json: { message: 'Product details fetched successfully.', products: @product.attributes.slice('id','name', 'description').merge(product_category: @product.product_category.try(:name), product_images: @product.images.pluck(:content), product_variants: @product_variants.as_json(only: [:id, :variation_name, :size, :color, :price, :discounted_price, :availibility]))}, status: 200)
    else
      render(json: { message: 'No product found.'}, status: 500)
    end
  end

  def purchases
    @purchases = Purchase.all.order("created_at desc")
    if @purchases.present?
      render(json: { message: 'Purchase details fetched successfully.', purchases: @purchases.map{|purchase| purchase.attributes.merge(product: purchase.product.as_json(only: [:id, :name, :description]), product_images: purchase.product.images.pluck(:content), product_category: purchase.product.product_category.try(:name), product_variant: purchase.product_variation.as_json(only: [:id, :variation_name, :size, :color, :price, :discounted_price, :availibility]))}}, status: 200)
    else
      render(json: { message: 'No purchase found.'}, status: 500)
    end
  end
end
