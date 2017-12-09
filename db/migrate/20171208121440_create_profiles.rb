class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :surname
      t.string :full_name
      t.string :phone

      t.timestamps
    end


    add_reference :users, :profile, references: :profiles, index: true
    add_foreign_key :users, :profiles, column: :profile_id
  end
end
