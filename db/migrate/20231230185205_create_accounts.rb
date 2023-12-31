class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :pluggy_id
      t.string :item_id
      t.integer :user_id
      # t.string :transfer_number
      # t.string :bank_name
      # t.string :name
      # t.float :balance

      t.timestamps
    end
  end
end
