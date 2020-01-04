class CreateStats501s < ActiveRecord::Migration[6.0]
  def change
    create_table :stats501s do |t|
      t.references :player, null: false, foreign_key: true
      t.references :season, null: false, foreign_key: true
      t.integer :week
      t.integer :legs_won
      t.integer :legs_lost
      t.boolean :match_won
      t.integer :darts
      t.integer :points
      t.integer :average
      t.integer :ppd

      t.timestamps
    end
  end
end
