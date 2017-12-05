class RemoveColumnFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :address_id, :string
  end
end
