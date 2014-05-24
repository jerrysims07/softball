class GamesController < ApplicationController

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

  def list game
    @games = Game.all
  end
end
