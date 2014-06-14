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
  end

end
