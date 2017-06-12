class CreateSession < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user
      t.string :session_id
      t.integer :status
      t.datetime :validity

      t.timestamps
    end
  end
end
