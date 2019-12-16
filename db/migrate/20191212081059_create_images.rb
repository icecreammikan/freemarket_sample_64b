class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.references :item, foreign_key: {to_table: :items}, null: false
      t.text :image_url, null: false
      t.timestamps
    end
  end
end
