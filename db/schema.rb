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

ActiveRecord::Schema.define(version: 20171204135105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "country"
    t.string "region"
    t.string "city"
    t.string "street"
    t.string "building_number"
    t.string "apartment_number"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "cargos", force: :cascade do |t|
    t.bigint "transporter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transporter_id"], name: "index_cargos_on_transporter_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "receipt_date"
    t.datetime "delivery_date"
    t.decimal "price"
    t.bigint "user_id"
    t.bigint "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "packages", force: :cascade do |t|
    t.integer "weight"
    t.integer "height"
    t.integer "width"
    t.bigint "cargo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "length"
    t.index ["cargo_id"], name: "index_packages_on_cargo_id"
  end

  create_table "transporters", force: :cascade do |t|
    t.integer "loading_space"
    t.integer "max_weight"
    t.integer "average_speed"
    t.boolean "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "supervisor_role", default: false
    t.boolean "courier", default: false
    t.boolean "user_role", default: true
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "surname"
    t.integer "addresses"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid"
  end

  add_foreign_key "cargos", "transporters"
  add_foreign_key "orders", "addresses"
  add_foreign_key "orders", "users"
  add_foreign_key "packages", "cargos"
end
