class AddReadToToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :read_to, :integer, default: 0
  end
end
