class GamesController < ApplicationController

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
    @game = Game.find(params[:id])
    @game.away_team_runs = params[:game][:away_team_runs] == "" ? nil : params[:game][:away_team_runs]
    @game.home_team_runs = params[:game][:home_team_runs] == "" ? nil : params[:game][:home_team_runs]
    @game.date =  params[:game]["date(1i)"] + "-" + params[:game]["date(2i)"] + "-" + params[:game]["date(3i)"] + " " + params[:game]["date(4i)"] + ":" + params[:game]["date(5i)"] + ":00"


    if @game.save
      redirect_to standings_path
    else
      redirect_to back
    end
  end

end
