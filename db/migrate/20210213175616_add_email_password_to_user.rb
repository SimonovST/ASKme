class AddEmailPasswordToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :emai, :string
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string

    add_column :users, :avatar_url, :string
  end
end
