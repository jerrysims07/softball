class Game < ActiveRecord::Base

  validate :home_team_id_cannot_equal_away_team_id
  belongs_to :home_team, class_name: 'Team', foreign_key: 'home_team_id'
  belongs_to :away_team, class_name: 'Team', foreign_key: 'away_team_id'


  def teams
    [home_team.name, away_team.name]
  end

  def status
    ( home_team_runs.nil? ||
      away_team_runs.nil?||
      home_team.nil? ||
      away_team.nil?        ) ? :scheduled : :played
  end

  def self.update (params)
    @game = Game.find(params[:id])
    game_params = params.require(:game).permit(:date, :away_team_runs, :home_team_runs)
    @game.away_team_runs = params[:game][:away_team_runs] == "" ? nil : params[:game][:away_team_runs]
    @game.home_team_runs = params[:game][:home_team_runs] == "" ? nil : params[:game][:home_team_runs]
    if @game.update_attributes(game_params) && @game.status == :played
      self.update_tournament_games(@game)
    end

    #The @game doesn't seem to be updated here
    @game
  end

  def self.update_tournament_games game
    @game = Game.find(game.id)
    winner_next = {game_number: game.winner_next[1..-1]}
    winner_next[:home_away] = :away_team if game.winner_next[0] == "A"
    winner_next[:home_away] = :home_team if game.winner_next[0] == "H"
    new_game = Game.where(tourney_game_number: winner_next[:game_number]).first
    team = @game.winner
    new_game.update_attributes(winner_next[:home_away] => team)
    return if @game.loser_next.nil?
    loser_next = {game_number: game.loser_next[1..-1]}
    loser_next[:home_away] = :away_team if game.loser_next[0] == "A"
    loser_next[:home_away] = :home_team if game.loser_next[0] == "H"
    new_game = Game.where(tourney_game_number: loser_next[:game_number]).first
    team = @game.loser
    new_game.update_attributes(loser_next[:home_away] => team)
  end

  def home_team_id_cannot_equal_away_team_id
    if home_team_id.present? && home_team_id == away_team_id
      errors.add(:home_team_id, "cannot equal away_team_id")
    end
  end

  def winner
    return nil if status == :scheduled
    return home_team if home_team_runs > away_team_runs
    return away_team if away_team_runs > home_team_runs
    return "tie" if home_team_runs == away_team_runs
  end

  def loser
    return nil if @game.nil? || @game.status == :scheduled
    return home_team if home_team_runs < away_team_runs
    return away_team if away_team_runs < home_team_runs
    return "tie" if home_team_runs == away_team_runs
  end
end
