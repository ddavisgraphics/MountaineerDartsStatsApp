class CreateMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :memberships do |t|
      t.references :player, index: true
      t.references :team, index: true
      t.boolean :captain
      t.timestamps
    end
  end
end
