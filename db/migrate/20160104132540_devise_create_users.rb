class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.datetime :remember_created_at

      t.datetime :last_sign_in_at

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
  end
end