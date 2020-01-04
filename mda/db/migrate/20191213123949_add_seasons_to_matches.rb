class AddSeasonsToMatches < ActiveRecord::Migration[6.0]
  def change
    add_reference :matches, :season, null: false, foreign_key: true
  end
end
