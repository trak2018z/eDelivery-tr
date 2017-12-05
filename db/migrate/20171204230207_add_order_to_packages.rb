class AddOrderToPackages < ActiveRecord::Migration[5.1]
  def change
    add_reference :packages, :order, foreign_key: true
  end
end
