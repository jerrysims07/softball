class RemoveNextGamesFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :winner_next_game
    remove_column :games, :loser_next_game
  end
end
