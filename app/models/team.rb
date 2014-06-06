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
    Game.where("(home_team_id = ? OR away_team_id = ?) AND home_team_runs = away_team_runs", id, id).count
  end

  def pct
    self.games.nil? ? 0 : self.wins.to_f / (self.wins + self.losses)
  end

  def runs_for
    sum = 0
    self.games.each do |g|
      sum += self.name == g.home_team.name ? g.home_team_runs.to_i : g.away_team_runs.to_i
    end
    sum
  end

  def runs_allowed
    sum = 0
    self.games.each do |g|
      sum += self.name == g.home_team.name ? g.away_team_runs.to_i : g.home_team_runs.to_i
    end
    sum
  end

  def games_played
    wins + losses + ties
  end

end
