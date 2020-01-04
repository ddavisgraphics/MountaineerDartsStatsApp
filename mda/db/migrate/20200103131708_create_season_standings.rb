class CreateSeasonStandings < ActiveRecord::Migration[6.0]
  def change
    create_table :season_standings do |t|
      t.references :team, null: false, foreign_key: true
      t.references :season, null: false, foreign_key: true
      t.integer :wins
      t.integer :losses
      t.integer :points

      t.timestamps
    end
  end
end
