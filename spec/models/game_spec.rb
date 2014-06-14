require 'spec_helper'

describe Game do

  it "returns correct class name for new Game" do
    game = Game.new
    game.class.should eq(Game)
  end

  context "that has been played" do
    before(:each) do
      @t1 = Team.new(:id => 1)
      @t2 = Team.new(:id => 2)
      Game.new(id: 1, date: 2014-06-01, home_team_id: 1, away_team_id: 2, home_team_runs: 2, away_team_runs: 1).save!
    end

    it "returns the correct winner" do
      @t1.wins.should eq(1)
    end

    it "returns the correct loser" do
      @t2.losses.should eq(1)
    end

  end

end
