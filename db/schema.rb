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

ActiveRecord::Schema.define(version: 20171026193906) do

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.integer  "runtime"
    t.float    "rate"
    t.text     "plot"
    t.string   "poster"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "year"
  end

  add_index "movies", ["title", "runtime", "year"], name: "index_movies_on_title_and_runtime_and_year", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "image"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "auth_token",      default: ""
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "users_movies", force: :cascade do |t|
    t.integer "user_id"
    t.integer "movie_id"
    t.boolean "watched",  default: false
    t.boolean "favorite", default: false
  end

  add_index "users_movies", ["user_id", "movie_id"], name: "index_users_movies_on_user_id_and_movie_id", unique: true

end
