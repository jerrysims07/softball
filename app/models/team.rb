class Team < ActiveRecord::Base
  has_many :games

  def games
    Game.where("home_team_id = ? OR away_team_id = ?", id, id)
  end

  def wins
  end
end
