class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nickname,         :string,  null: false
    add_column :users, :last_name,        :string,  null: false
    add_column :users, :first_name,       :string,  null: false
    add_column :users, :last_name_kana,   :string,  null: false
    add_column :users, :first_name_kana,  :string,  null: false
    add_column :users, :phone_number,     :string,  unique: true
    add_column :users, :birthyear_id,     :integer,    null: false, foreign_key: true
    add_column :users, :birthmonth_id,    :integer,    null: false, foreign_key: true
    add_column :users, :birthday,         :integer,    null: false, foreign_key: true
    add_column :users, :icon,             :text
    add_column :users, :header_image,     :text
    add_column :users, :introduce,        :text
    add_column :users, :authentication_number, :string
  end
end
