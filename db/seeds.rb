require 'csv'

csv_file_path = 'data/schedule.csv'

CSV.foreach(csv_file_path) do |row|
  Game.create!({
    :date => DateTime.strptime(row[0], "%m/%d/%Y").strftime("%Y/%m/%d"),
    :away_team_id => Team.where(:name => row[1])[0].id,
    :home_team_id => Team.where(:name => row[2])[0].id,
    :away_team_runs => row[3],
    :home_team_runs => row[4]
    # :position => "DEF",
    # :avgPtsAllowed => row[3],
    # :defSack => row[5],
    # :defINT => row[6],
    # :defFumbRec => row[7],
    # :defTD => row[14],
    # :defSafety => row[15],
    # :year => row[25]
  })
end
