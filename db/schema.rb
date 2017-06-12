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

ActiveRecord::Schema.define(version: 20170612053145) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.decimal  "critical_value"
    t.boolean  "notification"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.decimal  "balance",        default: 0.0
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_id"
    t.integer  "status"
    t.datetime "validity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "account_id"
    t.string   "purpose"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
