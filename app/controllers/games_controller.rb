class GamesController < ApplicationController

  include GamesHelper
  http_basic_authenticate_with :name => "commish", :password => "softball"

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
    @teams = Team.all
  end

  def create
    home_team_id = Team.find_by(name: params['game']['home_team_id']).id
    away_team_id = Team.find_by(name: params['game']['away_team_id']).id
    @game = Game.new(home_team_id: home_team_id, away_team_id: away_team_id)
    if @game.save
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def list game
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.update params
    if @game.game_type == "regular"
      redirect_to standings_path
    elsif @game.game_type == "tourney"
      redirect_to '/tournament'
    end
  end

  def tourney
    @tourney_games = Game.where("game_type = 'tourney'").sort_by(&:tourney_game_number)
  end
end
