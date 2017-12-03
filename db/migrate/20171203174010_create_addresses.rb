class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :region
      t.string :city
      t.string :street
      t.integer :building_number
      t.integer :apartment_number
      t.belongs_to :user

      t.timestamps
    end
  end
end
