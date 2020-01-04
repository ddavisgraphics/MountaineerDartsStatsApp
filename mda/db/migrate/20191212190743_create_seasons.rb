class CreateSeasons < ActiveRecord::Migration[6.0]
  def change
    create_table :seasons do |t|
      t.string :name
      t.date :start
      t.date :end
      t.timestamps
    end

    change_table :memberships do |t|
      t.references :seasons, index: true
    end
  end
end
