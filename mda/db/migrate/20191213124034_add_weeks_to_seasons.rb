class AddWeeksToSeasons < ActiveRecord::Migration[6.0]
  def change
    add_column :seasons, :week, :integer
  end
end
