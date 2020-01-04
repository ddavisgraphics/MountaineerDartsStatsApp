class AddWeekToAccoliads < ActiveRecord::Migration[6.0]
  def change
    add_column :accolaids, :week, :integer
    add_column :high_outs, :week, :integer
    add_column :high_ins, :week, :integer
  end
end
