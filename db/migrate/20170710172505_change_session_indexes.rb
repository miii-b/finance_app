class ChangeSessionIndexes < ActiveRecord::Migration
   def change
    remove_index :sessions, :id
    add_index :sessions, :session_id
  end
end
