class AddTourneyGameNumberToGames < ActiveRecord::Migration
  def change
    add_column :games, :tourney_game_number, :integer
  end
end
