require 'spec_helper'

describe GamesController do

  it "returns correct class name for new Game" do
    game = Game.new
    game.class.should eq(Game)
  end

end
