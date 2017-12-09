class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.datetime :receipt_date
      t.datetime :delivery_date
      t.decimal :price
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
