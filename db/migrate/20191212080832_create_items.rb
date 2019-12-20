class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :seller, foreign_key: {to_table: :users} ,null: false
      t.references :buyer, foreign_key: {to_table: :users} 
      t.string     :name, null: false, index: true
      t.string     :description, null:false
      t.references :category, null:false
      t.references :size
      t.references :brand
      t.references :condition, null:false
      t.references :prefecture, null:false
      t.references :sendingmethod, null:false
      t.references :postageburden, null:false
      t.references :shippingday, null:false
      t.integer    :price, null:false
      t.integer    :profit, null:false
      t.timestamps
    end
  end
end
