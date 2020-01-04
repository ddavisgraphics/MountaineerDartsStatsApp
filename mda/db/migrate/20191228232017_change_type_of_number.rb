class ChangeTypeOfNumber < ActiveRecord::Migration[6.0]
  def change
    change_column :accolaids, :accolaid, :string
  end
end
