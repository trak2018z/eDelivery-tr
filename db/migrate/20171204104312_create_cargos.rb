class CreateCargos < ActiveRecord::Migration[5.1]
  def change
    create_table :cargos do |t|
      t.belongs_to :transporter, foreign_key: true

      t.timestamps
    end
  end
end
