class CreateTransporters < ActiveRecord::Migration[5.1]
  def change
    create_table :transporters do |t|
      t.integer :loading_space
      t.integer :max_weight
      t.integer :average_speed
      t.boolean :available

      t.timestamps
    end
  end
end
