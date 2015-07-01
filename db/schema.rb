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

ActiveRecord::Schema.define(version: 20150608142504) do

  create_table "superheros", force: :cascade do |t|
    t.string  "deck"
    t.string  "descripton"
    t.string  "gender"
    t.string  "name"
    t.string  "real_name"
    t.string  "image"
    t.string  "birthday"
    t.string  "last_name"
    t.string  "publisher"
    t.string  "comic_vine_id"
    t.integer "sentiment_score", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string   "nickname"
    t.string   "email"
    t.string   "provider"
    t.string   "token"
    t.string   "uid"
    t.string   "image_url"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "sentiment_score", default: 0
    t.string   "oauth_secret"
  end

end
