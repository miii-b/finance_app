class AddDefaultToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :balance, :decimal, :default => 0
  end
end
