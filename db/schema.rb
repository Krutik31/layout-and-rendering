# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_501_082_849) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'addresses', force: :cascade do |t|
    t.string 'house_name'
    t.string 'street_name'
    t.string 'road'
    t.bigint 'employee_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['employee_id'], name: 'index_addresses_on_employee_id'
  end

  create_table 'employees', force: :cascade do |t|
    t.string 'employee_name'
    t.string 'email'
    t.string 'password'
    t.integer 'gender'
    t.text 'address'
    t.bigint 'mobile_number'
    t.date 'birth_date'
    t.string 'document'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'employees_hobbies', id: false, force: :cascade do |t|
    t.bigint 'employee_id', null: false
    t.bigint 'hobby_id', null: false
    t.index %w[employee_id hobby_id], name: 'index_employees_hobbies_on_employee_id_and_hobby_id'
    t.index %w[hobby_id employee_id], name: 'index_employees_hobbies_on_hobby_id_and_employee_id'
  end

  create_table 'hobbies', force: :cascade do |t|
    t.string 'hobby'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'orders', force: :cascade do |t|
    t.integer 'quantity'
    t.bigint 'total_amount'
    t.string 'order_status'
    t.bigint 'product_id', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['product_id'], name: 'index_orders_on_product_id'
    t.index ['user_id'], name: 'index_orders_on_user_id'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.bigint 'price'
    t.string 'capacity'
    t.boolean 'is_active'
    t.integer 'product_status'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'role'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'addresses', 'employees'
  add_foreign_key 'orders', 'products'
  add_foreign_key 'orders', 'users'
end
