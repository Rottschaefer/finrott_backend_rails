class CreateFixedTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :fixed_transactions do |t|
      t.string :user_id
      t.string :category
      t.string :description
      t.float :amount

      t.timestamps
    end
  end
end
