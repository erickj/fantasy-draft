class FantasyTeam < ActiveRecord::Base
  belongs_to :fantasy_league
  has_many :fantasy_players

  alias :league :fantasy_league
end
