class TeamsController < ApplicationController

  def index
    @teams = Team.all.sort_by(&:pct).reverse!

    @scores = Game.where("away_team_runs is not null and game_type = 'regular'").sort_by(&:date)
    @past_dates = []
    @scores.each do |s|
      @past_dates << s.date.beginning_of_day
    end
    @past_dates.uniq!

    @upcoming_games = Game.where(away_team_runs: nil, game_type: 'regular').sort_by(&:date)
    @dates = []
    @upcoming_games.each do |g|
      @dates << g.date.beginning_of_day
    end
    @dates.uniq!
  end

  def show
    @teams = Team.all.sort_by(&:name)
    @team = params[:team] ? Team.find_by(name: params[:team][:name]) : Team.find(params[:id])
  end

end
