class Game < ActiveRecord::Base

  validate :home_team_id_cannot_equal_away_team_id
  belongs_to :home_team, class_name: 'Team', foreign_key: 'home_team_id'
  belongs_to :away_team, class_name: 'Team', foreign_key: 'away_team_id'


  def teams
    [home_team.name, away_team.name]
  end

  def status
    home_team_runs.nil? && away_team_runs.nil? ? :scheduled : :played
  end

  def home_team_id_cannot_equal_away_team_id
    if home_team_id.present? && home_team_id == away_team_id
      errors.add(:home_team_id, "cannot equal away_team_id")
    end
  end
end
