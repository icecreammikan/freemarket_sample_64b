class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :seller, foreign_key: {to_table: :users} ,null: false
      t.references :buyer, foreign_key: {to_table: :users} 
      t.string :name, null: false, index: true
      t.string :description, null:false
      t.references :category_id, null:false
      t.references :size_id
      t.references :brand_id
      t.references :condition_id, null:false
      t.references :prefecture_id, null:false
      t.references :sendingmethod_id, null:false
      t.references :postageburden_id, null:false
      t.references :shippingday_id, null:false
      t.integer :price, null:false
      t.integer :profit
      t.timestamps
    end
  end
end
