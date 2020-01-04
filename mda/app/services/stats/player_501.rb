# Basic Namespace for modeling the data from forms into statistical data
# @description The Stats namespace has to be made because of the basic
# form created for collecting the results of MDA matches.  This was
# preset by past leagues and is generally working so it is being kept.
# Keeping data entry the same allows for easier data entry and less
# headaches.  It is identical to what players will hand in so
# less prone to errors.
# @author David J. Davis
module Stats
  # This subclass does all the logic for creating the 501
  # statistics for each player.
  # @author David J. Davis
  # @return string
  class Player501
    def initialize(match)
      @match = match.deep_symbolize_keys
    end

    # Collects the numerical values for stats
    # @author David J. Davis
    # @return hash
    def leg_data
      record = {
        legs_won: 0,
        legs_lost: 0,
        match_won: false,
        darts: 0,
        points: 0
      }
      @match[:legs].each do |leg|
        record[:darts] += leg[1][:darts].to_f
        record[:points] += leg[1][:points].to_f

        if leg[1][:result] == 'Win'
          record[:legs_won] += 1
        else
          record[:legs_lost] += 1
        end
        
        record[:match_won] = true if record[:legs_won] >= 2
      end
      return record
    end

    def generate_averages
      data = self.leg_data
      ppd = (data[:points]/data[:darts]).round(3)
      avg = (ppd * 3).round(3)
      { average: avg, ppd: ppd }
    end

    # Send back a hash of good data to go into the database.
    # @author David J. Davis
    # @return string
    def match_stats
      data = self.leg_data
      data[:player_id] = @match[:player]
      avgs = self.generate_averages
      data.merge!(avgs)
    end
  end
end