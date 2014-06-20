require 'spec_helper'

describe Team do

  context "with no games played" do

    before(:each) do
      @team = Team.new
    end

    it "returns correct class name for new Team" do
      @team.class.should eq(Team)
    end

    it "returns 0 wins" do
      @team.wins.should eq(0)
    end

    it "returns 0 losses" do
      @team.losses.should eq(0)
    end

    it "returns 0 ties" do
      @team.ties.should eq(0)
    end

    it "returns 0 runs scored" do
      @team.runs[:for].should eq(0)
    end

    it "returns 0 runs allowed" do
      @team.runs[:allowed].should eq(0)
    end

    it "return 0 games played" do
      @team.games_played.should eq(0)
    end

    it "should not return a seed" do
      @team.seed.should eq(nil)
    end
  end

  context "which has played games" do
    it "should return a seed" do
      t1 = Team.create
      t2 = Team.create
      Game.create(home_team_id: t1.id, away_team_id: t2.id, home_team_runs: 10, away_team_runs: 5)
      t1.seed.should eq(1)
      t2.seed.should eq(2)
    end

    it "returns a seed with more than 2 teams" do
      t1 = Team.create
      t2 = Team.create
      t3 = Team.create
      Game.create(home_team_id: t1.id, away_team_id: t2.id, home_team_runs: 10, away_team_runs: 5)
      Game.create(home_team_id: t1.id, away_team_id: t3.id, home_team_runs: 10, away_team_runs: 5)
      Game.create(home_team_id: t2.id, away_team_id: t3.id, home_team_runs: 10, away_team_runs: 5)
      t1.seed.should eq(1)
      t2.seed.should eq(2)
      t3.seed.should eq(3)
    end

    it "should be ranked higher than team they beat head-to-head" do
      t1 = Team.create
      t2 = Team.create
      t3 = Team.create
      t4 = Team.create
      Game.create(home_team_id: t2.id, away_team_id: t1.id, home_team_runs: 10, away_team_runs: 5)
      Game.create(home_team_id: t2.id, away_team_id: t3.id, home_team_runs: 10, away_team_runs: 5)
      Game.create(home_team_id: t4.id, away_team_id: t2.id, home_team_runs: 10, away_team_runs: 5)
      Game.create(home_team_id: t1.id, away_team_id: t3.id, home_team_runs: 10, away_team_runs: 5)
      Game.create(home_team_id: t1.id, away_team_id: t4.id, home_team_runs: 10, away_team_runs: 5)
      t1.seed.should eq(2)
      t2.seed.should eq(1)
      t3.seed.should eq(4)
      t4.seed.should eq(3)
    end
  end
end
