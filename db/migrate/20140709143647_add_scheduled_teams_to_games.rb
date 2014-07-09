class AddScheduledTeamsToGames < ActiveRecord::Migration
  def change
    add_column :games, :scheduled_home, :string
    add_column :games, :scheduled_away, :string
  end
end
