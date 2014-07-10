class AddNextGameToGames < ActiveRecord::Migration
  def change
    add_column :games, :winner_next_game, :integer
    add_column :games, :loser_next_game, :integer
  end
end
