class CreateAccolaids < ActiveRecord::Migration[6.0]
  def change
    create_table :accolaids do |t|
      t.references :season, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.integer :type
      t.integer :number

      t.timestamps
    end
  end
end
