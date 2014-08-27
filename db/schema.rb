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

ActiveRecord::Schema.define(version: 20140819113100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendees", force: true do |t|
    t.integer  "event_id",   null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendees", ["event_id", "user_id"], name: "index_attendees_on_event_id_and_user_id", unique: true, using: :btree
  add_index "attendees", ["user_id", "event_id"], name: "index_attendees_on_user_id_and_event_id", unique: true, using: :btree

  create_table "events", force: true do |t|
    t.string   "title"
    t.datetime "date"
    t.string   "place"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "field_values", force: true do |t|
    t.integer  "field_id",    null: false
    t.integer  "attendee_id", null: false
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "field_values", ["attendee_id"], name: "index_field_values_on_attendee_id", using: :btree
  add_index "field_values", ["field_id"], name: "index_field_values_on_field_id", using: :btree

  create_table "fields", force: true do |t|
    t.integer  "event_id",                      null: false
    t.string   "name",                          null: false
    t.string   "type",         default: "text", null: false
    t.boolean  "required",     default: false,  null: false
    t.boolean  "multiple",     default: false,  null: false
    t.string   "option_items",                               array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fields", ["event_id"], name: "index_fields_on_event_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
