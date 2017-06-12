class CreateTransaction < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :user
      t.references :category
      t.references :account

      t.string :purpose
      t.decimal :amount

      t.timestamps
    end
  end
end
