class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :pluggy_id
      t.text :description
      t.string :currency_code
      t.decimal :amount
      t.datetime :date
      t.string :category
      t.string :category_id
      t.string :account_pluggy_id      
      t.string :status
      t.string :transaction_type
      t.string :merchant_business_name
      t.string :merchant_category
      t.string :user_id

      t.timestamps
    end
  end
end
