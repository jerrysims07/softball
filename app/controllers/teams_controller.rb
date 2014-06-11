class TeamsController < ApplicationController

  def index
    @teams = Team.all.sort_by(&:pct)
    @teams.reverse!

    @scores = Game.where.not(away_team_runs: nil).sort_by(&:date)
    @past_dates = []
    @scores.each do |s|
      @past_dates << s.date
    end
    @past_dates.uniq!

    @upcoming_games = Game.where(away_team_runs: nil)

    @dates = []
    @upcoming_games.each do |g|
      @dates << g.date
    end
    @dates.uniq!
  end

  def show
    @teams = Team.all.sort_by(&:name)
    @team = params[:team] ? Team.find_by(name: params[:team][:name]) : Team.find(params[:id])
  end

end
