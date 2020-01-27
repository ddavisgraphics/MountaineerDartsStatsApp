class SeasonStanding < ApplicationRecord
  belongs_to :team
  belongs_to :season
  

  def division
    self.team.division.name
  end 
end
