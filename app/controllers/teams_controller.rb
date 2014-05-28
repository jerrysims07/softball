class TeamsController < ApplicationController

  def index
    @teams = Team.all
    @teams = @teams.sort {|a, b| a.pct <=> b.pct}
    @teams.reverse!
  end

end
