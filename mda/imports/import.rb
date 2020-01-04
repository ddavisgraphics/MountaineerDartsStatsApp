require 'csv'

data = []
CSV.foreach("imports/data.csv", {:headers => true, :header_converters => :symbol}) do |row|
  data << row.to_hash
end

# create teams 
# CSV.foreach('imports/teams.csv', {:headers => true, :header_converters => :symbol}) do |row|
#   Team.new(row.to_hash).save
# end 

# p Team.all.count

data.each do |player|
  team = Team.where(name: player[:team].strip).first
  puts "#{player[:team]} has not been found" if team.nil? 
  break if team.nil? 
  season = Season.find(2)
  saved_player = Player.new(name: player[:player])
  saved_player.save
  membership = Membership.new(player: saved_player, team: team, captain: false, season: season)
  membership.save
  p "#{player[:player]} has been saved!"
end