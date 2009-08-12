class DraftSelection < ActiveRecord::Base
  belongs_to :draft
  belongs_to :fantasy_team
  belongs_to :fantasy_player

  def name
    FantasyPlayer.find(:first, {:conditions => ["player_id = ?", fantasy_player_id]}).name
  end
end
