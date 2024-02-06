class ChangingAccountsTable < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :bank_id, :integer
    remove_column :accounts, :pluggy_id, :string
    remove_column :accounts, :item_id, :string
    remove_column :accounts, :bank_primary_color, :string
    remove_column :accounts, :institution_url, :string
    remove_column :accounts, :institution_image_url, :string
  end
end
