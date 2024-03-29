# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_12_075741) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "images", force: :cascade do |t|
    t.string "content"
    t.string "imageable_type"
    t.integer "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id"
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_product_categories_on_name"
  end

  create_table "product_variations", force: :cascade do |t|
    t.string "variation_name"
    t.string "size"
    t.string "color"
    t.decimal "price", precision: 8, scale: 2
    t.decimal "discounted_price", precision: 8, scale: 2
    t.boolean "availibility", default: true
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["availibility"], name: "index_product_variations_on_availibility"
    t.index ["color"], name: "index_product_variations_on_color"
    t.index ["price"], name: "index_product_variations_on_price"
    t.index ["product_id"], name: "index_product_variations_on_product_id"
    t.index ["size"], name: "index_product_variations_on_size"
    t.index ["variation_name"], name: "index_product_variations_on_variation_name"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "price", precision: 8, scale: 2
    t.decimal "discounted_price", precision: 8, scale: 2
    t.bigint "product_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_products_on_name"
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "product_variation_id"
    t.string "quantity", default: "0"
    t.string "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_purchases_on_product_id"
    t.index ["product_variation_id"], name: "index_purchases_on_product_variation_id"
  end

  add_foreign_key "product_variations", "products"
  add_foreign_key "products", "product_categories"
  add_foreign_key "purchases", "product_variations"
  add_foreign_key "purchases", "products"
end
