class CreateHighIns < ActiveRecord::Migration[6.0]
  def change
    create_table :high_ins do |t|
      t.references :season, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
