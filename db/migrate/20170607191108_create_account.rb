class CreateAccount < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.decimal :critical_value
      t.boolean :notification

      t.timestamps 
    end
  end
end

