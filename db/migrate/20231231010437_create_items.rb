class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :pluggy_id
      t.integer :user_id

      t.timestamps
    end
  end
end
