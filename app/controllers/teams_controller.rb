class TeamsController < ApplicationController

  def index
    @teams = Team.all

    @teams = @teams.sort_by(&:pct)
    # @teams = @teams.sort {|a, b| a.pct <=> b.pct}
    @teams.reverse!

    @scores = Game.where.not(away_team_runs: nil).sort_by(&:date)


    @upcoming_games = Game.where(away_team_runs: nil)

    @dates = []
    @upcoming_games.each do |g|
      @dates << g.date
    end
    @dates.uniq!
  end

  def show
    @team = Team.find(params[:id])
  end

end
