class AddDateToFixedTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :fixed_transactions, :date, :string

  end
end
