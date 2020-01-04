class CreateStatsChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :stats_choices do |t|
      t.references :season, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.integer :week
      t.integer :legs_won
      t.integer :legs_lost
      t.boolean :match_won

      t.timestamps
    end
  end
end
