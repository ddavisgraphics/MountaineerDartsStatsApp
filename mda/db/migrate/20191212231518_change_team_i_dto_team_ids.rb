class ChangeTeamIDtoTeamIds < ActiveRecord::Migration[6.0]
  def change
    remove_column :divisions, :teams_id 
    add_column :divisions, :team_ids, :string, array: true, default: []
  end
end
