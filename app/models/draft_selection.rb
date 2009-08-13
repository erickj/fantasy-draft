class DraftSelection < ActiveRecord::Base
  belongs_to :draft
  belongs_to :fantasy_team
  belongs_to :fantasy_player

  def player
    fantasy_player.player
  end

  def fantasy_player
    FantasyPlayer.find(:first, {:conditions => ["player_id = ?", fantasy_player_id]})
  end

  def name
    fantasy_player.name
  end
end
