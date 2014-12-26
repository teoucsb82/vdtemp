# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141225064110) do

  create_table "apartments", force: true do |t|
    t.string   "unit",                        null: false
    t.integer  "bedrooms",                    null: false
    t.float    "bathrooms",                   null: false
    t.text     "description"
    t.text     "metadata"
    t.boolean  "available",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "property_id"
  end

  create_table "images", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "active",             default: false
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "properties", force: true do |t|
    t.text     "street_address",                null: false
    t.string   "city",                          null: false
    t.string   "state",          default: "CA", null: false
    t.integer  "zip",                           null: false
    t.text     "metadata"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "properties", ["street_address"], name: "index_properties_on_street_address", unique: true

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "apartment_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
