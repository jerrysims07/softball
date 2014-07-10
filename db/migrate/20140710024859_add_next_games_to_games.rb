class AddNextGamesToGames < ActiveRecord::Migration
  def change
    add_column :games, :winner_next, :string
    add_column :games, :loser_next, :string
  end
end
