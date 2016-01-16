class AddTrackableToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.datetime "current_sign_in_at"
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.integer  "sign_in_count", default: 0
    end
  end
end
