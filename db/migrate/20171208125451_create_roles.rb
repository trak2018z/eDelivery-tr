class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.integer :value
      t.string :code
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end

    ['admin', 'manager', 'courier'].each do |role|
      Role.find_or_create_by({name: role})
    end

  end
end
