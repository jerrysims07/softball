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
    unless games_played == 0
      build_seed
    end
  end

  private
  def build_seed
    standings = Team.all.sort_by(&:pct).reverse.to_a
    standings.length.times do |i|
      if(i + 1 != standings.length && standings[i].pct == standings[i+1].pct)
        if need_to_flip? [standings[i], standings[i+1]]
          standings.insert(i, standings.delete_at(i+1))
        end
      end
    end
    standings.find_index(self).to_i + 1
  end

  def need_to_flip?(teams)
    games = Game.where("away_team_id = ? OR home_team_id = ?", teams[0].id, teams[0].id)
                .where("away_team_id = ? OR home_team_id = ?", teams[1].id, teams[1].id).to_a
    if games[0].winner == teams[0]
      false
    elsif games[0].winner == teams[1]
      true
    else
      "Something went horribly wrong"
    end
  end
end
