class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :home_team_runs
      t.integer :away_team_runs
      t.datetime :date

      t.timestamps
    end
  end
end
