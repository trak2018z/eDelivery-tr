class AddLengthToPackages < ActiveRecord::Migration[5.1]
  def change
    add_column :packages, :length, :integer
  end
end
