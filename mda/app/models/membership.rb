class Membership < ApplicationRecord
  belongs_to :team
  belongs_to :player
  belongs_to :season

  def team_name
    team.name
  end
  
  def player_name
    player.name
  end

  def season_name
    season.name
  end
end
