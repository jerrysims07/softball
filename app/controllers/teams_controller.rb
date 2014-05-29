class TeamsController < ApplicationController

  def index
    @teams = Team.all
    @teams = @teams.sort {|a, b| a.pct <=> b.pct}
    @teams.reverse!

    @scores = Game.where.not(away_team_runs: nil)

    @upcoming_games = Game.where(away_team_runs: nil)
  end

end
