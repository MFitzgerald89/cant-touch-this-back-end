ActiveRecord::Schema[7.0].define(version: 2023_06_06_002611) do
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.float "latitude"
    t.float "longitude"
    t.string "city"
    t.string "state"
  end

end
