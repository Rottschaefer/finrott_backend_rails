class CreateBanks < ActiveRecord::Migration[7.1]
  def change
    create_table :banks do |t|
      t.string :name
      t.string :primary_color
      t.string :institution_url
      t.string :institution_image_url

      t.timestamps
    end
  end
end
