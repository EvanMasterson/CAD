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

ActiveRecord::Schema.define(version: 20180411170152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clinics", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "specialisation"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "firstName"
    t.string "clinic"
    t.string "specialisation"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lastName"
    t.string "email"
    t.index ["patient_id"], name: "index_doctors_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "firstName"
    t.date "dob"
    t.string "address"
    t.integer "phone"
    t.string "symptom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lastName"
    t.bigint "doctor_id"
    t.string "email"
    t.string "category"
    t.index ["doctor_id"], name: "index_patients_on_doctor_id"
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
    t.boolean "admin", default: false
    t.boolean "doctor", default: false
    t.boolean "patient", default: true
    t.string "firstName"
    t.string "lastName"
    t.date "dob"
    t.string "address"
    t.integer "phone"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "doctors", "patients"
  add_foreign_key "patients", "doctors"
end
