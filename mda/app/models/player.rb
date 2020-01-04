class Player < ApplicationRecord
  has_many :memberships
  has_many :teams, through: :memberships
  has_many :seasons, through: :memberships

  has_many :stats501s
  has_many :stats_choices
  has_many :stats_crickets
  has_many :accolaids

  # SCOPES
  # -----------------------------------------------------
  
  def captain?
    memberships.where(captain: true).any?
  end

  def season_singles_stats(season_id)
    stats501s.where(season_id: season_id).select(:id, :week, :legs_won, :legs_lost, :match_won, :darts, :points, :average, :ppd).order(:week)
  end

  def season_cricket_stats(season_id)
    stats_crickets.where(season_id: season_id).select(:id, :week, :legs_lost, :legs_won, :match_won)
  end

  def season_choice_stats(season_id)
    stats_choices.where(season_id: season_id).select(:id, :week, :legs_lost, :legs_won, :match_won)
  end

  def season_accolaids(season_id)
    accolaids.where(season_id: season_id).select(:week, :accolaid, :number)
  end 
end
