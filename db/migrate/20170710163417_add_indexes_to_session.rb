class AddIndexesToSession < ActiveRecord::Migration
  def change
    add_index :sessions, [:user_id, :status]
  end
end
