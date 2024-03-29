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

ActiveRecord::Schema.define(version: 20160710091117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "objectives", force: :cascade do |t|
    t.string   "title",                       null: false
    t.integer  "progress_start"
    t.integer  "progress_target"
    t.integer  "progress_value"
    t.string   "progress_unit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.integer  "parent_id"
    t.integer  "level",           default: 0
    t.integer  "lft",                         null: false
    t.integer  "rgt",                         null: false
  end

  add_index "objectives", ["level"], name: "index_objectives_on_level", using: :btree
  add_index "objectives", ["lft"], name: "index_objectives_on_lft", using: :btree
  add_index "objectives", ["owner_id"], name: "index_objectives_on_owner_id", using: :btree
  add_index "objectives", ["parent_id"], name: "index_objectives_on_parent_id", using: :btree
  add_index "objectives", ["progress_value", "progress_target"], name: "index_objectives_on_progress_value_and_progress_target", using: :btree
  add_index "objectives", ["rgt"], name: "index_objectives_on_rgt", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["team_id"], name: "index_users_on_team_id", using: :btree

  add_foreign_key "objectives", "objectives", column: "parent_id"
  add_foreign_key "objectives", "users", column: "owner_id"
  add_foreign_key "users", "teams"
end
