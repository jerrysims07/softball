require 'csv'

csv_file_path = 'data/teams.csv'

CSV.foreach(csv_file_path) do |row|
  Team.create!({
    :name => row[0],
    :abbr => row[1]
  })
end

csv_file_path = 'data/schedule.csv'

CSV.foreach(csv_file_path) do |row|
  Game.create!({
    :date => DateTime.strptime(row[0], "%m/%d/%Y").strftime("%Y/%m/%d"),
    :away_team_id => Team.where(:name => row[1])[0].id,
    :home_team_id => Team.where(:name => row[2])[0].id,
    :away_team_runs => row[3],
    :home_team_runs => row[4]
  })
end
