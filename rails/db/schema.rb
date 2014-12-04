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

ActiveRecord::Schema.define(version: 20141204125322) do

  create_table "events", force: true do |t|
    t.string   "title",           null: false
    t.text     "questions"
    t.date     "invited_at",      null: false
    t.date     "closed_at",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "after_questions"
  end

  create_table "groups", force: true do |t|
    t.string   "iqube_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id",   null: false
    t.integer  "leader_id"
  end

  add_index "groups", ["event_id"], name: "index_groups_on_event_id", using: :btree
  add_index "groups", ["leader_id"], name: "index_groups_on_leader_id", using: :btree

  create_table "pages", force: true do |t|
    t.text     "body",                      null: false
    t.string   "permalink",                 null: false
    t.boolean  "is_public",  default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_groups", force: true do |t|
    t.integer  "user_id",                        null: false
    t.integer  "group_id"
    t.integer  "event_id",                       null: false
    t.text     "answers"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_participant", default: false, null: false
    t.text     "after_answers"
  end

  add_index "user_groups", ["event_id"], name: "index_user_groups_on_event_id", using: :btree
  add_index "user_groups", ["group_id"], name: "index_user_groups_on_group_id", using: :btree
  add_index "user_groups", ["user_id"], name: "index_user_groups_on_user_id", using: :btree

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "token"
    t.boolean  "is_admin",               default: false, null: false
    t.integer  "post_id"
    t.string   "skype_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
