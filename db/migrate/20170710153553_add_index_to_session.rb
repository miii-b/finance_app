class AddIndexToSession < ActiveRecord::Migration
  def change
    add_index :sessions, :id
  end
end
