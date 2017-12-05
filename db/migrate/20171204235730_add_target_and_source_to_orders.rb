class AddTargetAndSourceToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :source_address, references: :addresses, index: true
    add_foreign_key :orders, :addresses, column: :source_address_id
    add_reference :orders, :target_address, references: :addresses, index: true
    add_foreign_key :orders, :addresses, column: :target_address_id
  end
end
