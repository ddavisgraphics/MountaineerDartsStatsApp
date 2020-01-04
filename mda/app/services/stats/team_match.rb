# Basic Namespace for modeling the data from forms into statistical data
# @description The Stats namespace has to be made because of the basic
# form created for collecting the results of MDA matches.  This was
# preset by past leagues and is generally working so it is being kept.
# Keeping data entry the same allows for easier data entry and less
# headaches.  It is identical to what players will hand in so
# less prone to errors.
# @author David J. Davis
module Stats
  # This subclass creates the proper data for all the
  # team matches win/losses etc.
  # @author David J. Davis
  # @return string
  class TeamMatch
    def initialize(match, week, season)
      @match = match.deep_symbolize_keys
      @week = week
      @season = season
    end

    # Collects the numerical values for stats
    # @author David J. Davis
    # @return hash
    def match_data
      record = {
        legs_won: 0,
        legs_lost: 0,
        match_won: false,
        season_id: @season,
        week: @week
      }
      @match[:legs].each do |leg|
        if leg[1][:result] == 'Win'
          record[:legs_won] += 1
        else
          record[:legs_lost] += 1
        end
        record[:match_won] = true if record[:legs_won] >= 2
      end
      [record.merge({player_id: @match[:player_1] }), record.merge({player_id: @match[:player_2] }) ]
    end
  end
end