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

  def runs
    runs = {}
    runs[:for]=0
    runs[:allowed]=0
    self.games.each do |g|
      runs[:for]+= self.name == g.home_team.name ? g.home_team_runs.to_i : g.away_team_runs.to_i
      runs[:allowed]+= self.name == g.home_team.name ? g.away_team_runs.to_i : g.home_team_runs.to_i
    end
    runs
  end

  def games_played
    wins + losses + ties
  end

  def seed
    unless games_played.nil?
      build_seed Hash[Team.all.sort_by(&:pct).reverse.map.with_index(1).to_a], self
    end
  end

  private
  def build_seed(standings, team)
    standings[team]
  end

end
