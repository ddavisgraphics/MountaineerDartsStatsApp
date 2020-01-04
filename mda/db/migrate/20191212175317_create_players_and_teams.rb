class CreatePlayersAndTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :location
      t.timestamps
    end

    create_table :players do |t|
      t.string :name
      t.string :phone
      t.timestamps
    end
  end
end
