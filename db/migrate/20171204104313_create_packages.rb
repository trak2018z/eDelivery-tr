class CreatePackages < ActiveRecord::Migration[5.1]
  def change
    create_table :packages do |t|
      t.integer :weight
      t.integer :height
      t.integer :width
      t.references :cargo, foreign_key: true

      t.timestamps
    end
  end
end
