# Decorator to reduce view logic
class StatsDecorator < SimpleDelegator
  def self.singles(team_501)
    html = ""
    team_501.each do |plyr|
      html += "<div class='player-result'>"
      html += player_name(plyr[1][:player])
      html += legs(plyr[1][:legs])
      html += "</div>"
    end 
    return html
  end

  def self.team(match)
    html = ""
    match.each do |game|
      team = "#{player_name(game[1][:player_1])} / #{player_name(game[1][:player_2])}"
      total = 0;
      html += "<div class='team-match'>"
      html +=  "#{team}"
      html += "<div class='row'>"
      game[1][:legs].each do |leg|
        total += 1 if leg[1][:result] == 'Win' 
        html += "<div class='col #{leg[1][:result].downcase}'>"
          html += "Result: #{leg[1][:result].upcase}"
        html += "</div>"
      end
        html += "<div class='col totals'>"
          html += "Team Pts: #{total}"
        html += "</div>"
      html += "</div>"
      html += "</div>"
    end 
    return html
  end 

  # Returns Team Name
  # @author David J. Davis
  # @return [String] h3 with nested link
  def self.team_name(id)
    return '' unless id.present?
    team = Team.find(id)
    team.name
  end

  def self.player_name(id)
    return '' unless id.present?
    player = Player.find(id)
    "<strong> #{player.name} </strong>"
  end

  def self.legs(legs)
    html = "<div class='row'>"
    averages = generate_averages(legs)
    legs.each do |leg| 
      html += "<div class='col #{leg[1][:result].downcase}'>"
      html += "Darts: #{leg[1][:darts]} <br/> Points: #{leg[1][:points]} <br/> Result: #{leg[1][:result].upcase} <br/>"
      html += "</div>"
    end
    html += "<div class='col totals'> 
              <strong> Darts: </strong> #{averages[:total_darts]} <br/>
              <strong> Points: </strong> #{averages[:total_points]} <br/>
              <strong> PPD: </strong> #{averages[:ppd]} <br/>
              <strong> Team Pts: </strong> #{averages[:team_points]}
            </div>"
    html += "</div>" 
    return html
  end

  def self.generate_averages(legs)
    darts = 0; 
    points = 0;
    team_points = 0;
    legs.each do |leg|
      darts += leg[1][:darts].to_f
      points += leg[1][:points].to_f
      team_points += 1 if leg[1][:result] == 'Win'    
    end
    ppd = (points/darts).round(3)
    avg = (ppd * 3).round(3)
    { average: avg, ppd: ppd, total_darts: darts, total_points: points, team_points: team_points }
  end
end