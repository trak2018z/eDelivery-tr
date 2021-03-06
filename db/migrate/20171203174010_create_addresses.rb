class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :city
      t.string :postal_code
      t.string :street
      t.string :building_number
      t.string :apartment_number
      t.belongs_to :user

      t.timestamps
    end
  end
end
