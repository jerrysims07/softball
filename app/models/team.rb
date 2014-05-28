class Team < ActiveRecord::Base
  has_many :games

  def games
    Game.where("home_team_id = ? OR away_team_id = ?", id, id)
  end

  def wins
    Game.where("(home_team_id = ? AND home_team_runs > away_team_runs) OR (away_team_id = ? AND away_team_runs > home_team_runs)", id, id).count
  end

  def losses
    Game.where("(home_team_id = ? AND home_team_runs < away_team_runs) OR (away_team_id = ? AND away_team_runs < home_team_runs)", id, id).count
  end

  def ties
    Game.where("(home_team_id = ? OR away_team_id = ?) AND home_team_runs == away_team_runs", id, id).count
  end

  def pct
    self.wins.to_f / (self.wins + self.losses)
  end

end
