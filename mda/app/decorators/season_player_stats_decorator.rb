class SeasonPlayerStatsDecorator < SimpleDelegator
  def self.cumulative_singles_stats(stats)
    results = { 
      match_wins: 0, 
      match_losses: 0,
      mwp: 0,
      legs_won: 0, 
      legs_lost: 0, 
      lwp: 0,
      darts: 0,
      points: 0
    }
    stats.each do |stat|
      results[:legs_won] += stat[:legs_won]
      results[:legs_lost] += stat[:legs_lost]
      results[:match_wins] += 1 if stat[:match_won] == true
      results[:match_losses] += 1 if stat[:match_won] == false
      results[:darts] += stat[:darts]
      results[:points] += stat[:points]
    end
    results[:ppd] = (results[:points].to_f / results[:darts]).round(2)
    results[:avg] = (results[:ppd] * 3).round(2)
    results[:net_avg] = (results[:ppd] + results[:match_wins]).round(2)
    results[:mwp] = format_percentage(results[:match_wins], results[:match_losses])
    results[:lwp] = format_percentage(results[:legs_won], results[:legs_lost])
    return results
  end


  def self.cumulative_team_stats(stats)
    results = { 
      # match_wins: 0, 
      # match_losses: 0,
      # mwp: 0,
      legs_won: 0,
      legs_lost: 0,
      lwp: 0
    }
    stats.each do |stat|
      results[:legs_won] += stat[:legs_won]
      results[:legs_lost] += stat[:legs_lost]
      # results[:match_wins] += 1 if stat[:match_won] == true
      # results[:match_losses] += 1 if stat[:match_won] == false
    end
    # results[:mwp] = format_percentage(results[:match_wins], results[:match_losses])
    results[:lwp] = format_percentage(results[:legs_won], results[:legs_lost])
    return results
  end

  def self.format_percentage(wins, losses)
    value = ((wins / (wins.to_f + losses.to_f) ) * 100 ).round(2)
  end

  def self.mvp_points(sw, crw, chw)
    singles_points = sw.to_f 
    (singles_points + ((crw + chw) * 0.5)).round(2)
  end 

  def self.accolaids(stats)
    results = { 
      RON: 0, 
      T80: 0, 
      T71: 0, 
      weekly_bonus: 0
    }
    stats.each do |stat|
      results[:RON] += stat[:number] if stat[:accolaid] == "ron"
      results[:T80] += stat[:number] if stat[:accolaid] == "T80"
      results[:T71] += stat[:number] if stat[:accolaid] == "T71"
      results[:weekly_bonus] += 1 if ['high_in', 'high_avg', 'high_out'].include?(stat[:accolaid])
    end
    return results
  end 

  def self.calc_bonus(stats)
    bonus = 0
    bonus += (stats[:RON] * 10.00)
    bonus += (stats[:T80] * 10.00)
    bonus += (stats[:T71] * 9.00)
    bonus += (stats[:weekly_bonus] * 5.00)
    return bonus.round(2)
  end 
end