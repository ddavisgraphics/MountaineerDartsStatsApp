class ChangeTypeToAccType < ActiveRecord::Migration[6.0]
  def change
    remove_column :accolaids, :type
    add_column :accolaids, :accolaid, :integer
  end
end
