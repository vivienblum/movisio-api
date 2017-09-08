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

ActiveRecord::Schema.define(version: 20170908153159) do

  create_table "movie_users", force: :cascade do |t|
    t.integer  "users_id"
    t.integer  "movies_id"
    t.boolean  "watched",    default: false
    t.boolean  "favorite",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.integer  "runtime"
    t.float    "rate"
    t.text     "plot"
    t.string   "poster"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies_users", id: false, force: :cascade do |t|
    t.integer "user_id",  null: false
    t.integer "movie_id", null: false
    t.boolean "watched"
    t.boolean "favorite"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "mail"
    t.string   "password"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_movies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.boolean  "watched",    default: false
    t.boolean  "favorite",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
