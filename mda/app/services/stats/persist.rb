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
  class Persist
    # intialization of the match stuff
    def initialize(match, week, season_id)
      @match = match.deep_symbolize_keys
      @week = week
      @season_id = season_id
    end

    # Creates a hash for saving singles
    # @author David J. Davis
    # @return true
    def singles
      results = []
      @match[:"501"].each do |ply|
        player = ply[1]
        result = Stats::Player501.new(player).match_stats
        result[:week] = @week
        result[:season_id] = @season_id
        results << result
      end
      results
    end

    # Saves singles matches
    # @author David J. Davis
    # @return true
    def singles_save
      Stats501.create(self.singles)
    end
    
    # Updates / Saves Singles matches
    # @author David J. Davis
    # @return true
    def singles_update
      stats = self.singles
      stats.each do |stat|
        s = Stats501.where(week: stat[:week])
                   .where(player_id: stat[:player_id])
                   .where(season_id: stat[:season_id])
                   .first
        if s.present?
          s.update(stat)
        else
          Stats501.create(stat)
        end
      end
    end

    # team_stats
    # @author David J. Davis
    # @return true
    def team(match_type)
      results = []
      @match[match_type].each do |team|
        t = team[1]
        result = Stats::TeamMatch.new(t,@week, @season_id).match_data
        result.map { |obj| results << obj }
      end
      results
    end

    # Creates Choice stats for the match.
    # @author David J. Davis
    # @return true
    def choice_save
      StatsChoice.create(self.team(:choice))
    end

    # Updates Choice stats for the match.
    # @author David J. Davis
    # @return true
    def choice_update
      stats = self.team(:choice)
      stats.each do |stat|
        s = StatsChoice.where(week: stat[:week])
                        .where(player_id: stat[:player_id])
                        .where(season_id: stat[:season_id])
                        .first
        if s.present?
          s.update(stat)
        else
          StatsChoice.create(stat)
        end
      end
    end

    # Creates Cricket Stast for the match.
    # @author David J. Davis
    # @return true
    def cricket_save
      StatsCricket.create(self.team(:cricket))
    end

    # Updates / Creates Cricket Stast for the match.
    # @author David J. Davis
    # @return true
    def cricket_update
      stats = self.team(:cricket)
      stats.each do |stat|
        s = StatsCricket.where(week: stat[:week])
                        .where(player_id: stat[:player_id])
                        .where(season_id: stat[:season_id])
                        .first
        if s.present?
          s.update(stat)
        else
          StatsCricket.create(stat)
        end
      end
    end
  end
end
