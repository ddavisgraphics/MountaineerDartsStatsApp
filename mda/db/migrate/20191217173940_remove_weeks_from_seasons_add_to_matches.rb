class RemoveWeeksFromSeasonsAddToMatches < ActiveRecord::Migration[6.0]
  def change
    remove_column :seasons, :week
    add_column :matches, :week, :integer
  end
end
