class MigrateUserScheme < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :name, null: false
      t.string :full_name
      t.attachment :avatar

      t.change :email, :string, null: true
      t.remove_index :email

      t.index :name, unique: true
    end
  end
end
