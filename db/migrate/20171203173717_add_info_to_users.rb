class AddInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :addresses, :integer
  end
end
