class ChangeNumberToFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :accolaids, :accolaid, :integer
    change_column :accolaids, :number, :float
  end
end
