class AddMoreInfoToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :bank_primary_color, :string
    add_column :accounts, :institution_url, :string
    add_column :accounts, :institution_image_url, :string
    # remove_column :accounts, :name, :string
    # remove_column :accounts, :transfer_number, :string
  end
end
