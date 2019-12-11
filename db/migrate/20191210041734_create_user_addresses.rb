class CreateUserAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_addresses do |t|
      t.string :postcode, null: false
      t.integer :prefecture_id, null: false, foreign_key: true
      t.text :city, null: false
      t.text :address, null: false
      t.text :building_name
      t.string :send_phone_number
      t.integer :user_id, foreign_key: true
      t.string :a_last_name, null: false
      t.string :a_first_name, null: false
      t.string :a_last_name_kana, null: false
      t.string :a_first_name_kana, null: false
      t.timestamps
    end
  end
end
