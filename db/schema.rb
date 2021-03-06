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

ActiveRecord::Schema.define(version: 20181110170331) do

  create_table "grade_bands", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tree_type_id", null: false
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tree_type_id"], name: "index_grade_bands_on_tree_type_id"
  end

  create_table "locales", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "related_trees_trees", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "tree_id", null: false
    t.bigint "related_tree_id", null: false
    t.index ["tree_id", "related_tree_id"], name: "index_related_trees_trees_on_tree_id_and_related_tree_id"
  end

  create_table "sectors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code"
    t.string "name_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "base_key"
    t.index ["code"], name: "index_sectors_on_code"
  end

  create_table "sectors_trees", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "sector_id", null: false
    t.bigint "tree_id", null: false
    t.index ["sector_id", "tree_id"], name: "index_sectors_trees_on_sector_id_and_tree_id"
    t.index ["tree_id", "sector_id"], name: "index_sectors_trees_on_tree_id_and_sector_id"
  end

  create_table "subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tree_type_id", null: false
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tree_type_id"], name: "index_subjects_on_tree_type_id"
  end

  create_table "subjects_trees", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "subject_id", null: false
    t.bigint "tree_id", null: false
    t.index ["subject_id", "tree_id"], name: "index_subjects_trees_on_subject_id_and_tree_id"
    t.index ["tree_id", "subject_id"], name: "index_subjects_trees_on_tree_id_and_subject_id"
  end

  create_table "translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "locale"
    t.string "key"
    t.text "value"
    t.text "interpolations"
    t.boolean "is_proc", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_translations_on_key"
    t.index ["locale", "key"], name: "index_translations_on_keys"
    t.index ["value"], name: "index_translations_on_value", length: { value: 256 }
  end

  create_table "tree_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tree_type_id", null: false
    t.integer "version_id", null: false
    t.integer "subject_id", null: false
    t.integer "grade_band_id", null: false
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_key"
    t.string "base_key"
    t.string "matching_codes", default: "[]"
    t.integer "depth", default: 0
    t.index ["grade_band_id"], name: "index_trees_on_grade_band_id"
    t.index ["name_key"], name: "index_trees_on_name_key"
    t.index ["subject_id"], name: "index_trees_on_subject_id"
    t.index ["tree_type_id", "version_id", "subject_id", "grade_band_id", "code"], name: "index_trees_on_keys"
    t.index ["tree_type_id"], name: "index_trees_on_tree_type_id"
    t.index ["version_id"], name: "index_trees_on_version_id"
  end

  create_table "uploads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "subject_id", null: false
    t.integer "grade_band_id", null: false
    t.integer "locale_id", null: false
    t.integer "status"
    t.text "status_detail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "filename"
    t.text "statusPhase2"
    t.index ["grade_band_id"], name: "index_uploads_on_grade_band_id"
    t.index ["locale_id"], name: "index_uploads_on_locale_id"
    t.index ["subject_id", "grade_band_id", "locale_id"], name: "index_uploads_on_keys"
    t.index ["subject_id"], name: "index_uploads_on_subject_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "given_name", default: ""
    t.string "family_name", default: ""
    t.string "roles", default: "", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "govt_level"
    t.string "govt_level_name"
    t.string "municipality"
    t.string "institute_type"
    t.string "institute_name_loc"
    t.string "position_type"
    t.string "subject1"
    t.string "subject2"
    t.string "gender"
    t.string "education_level"
    t.string "work_phone"
    t.string "work_address"
    t.boolean "terms_accepted"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
