class FantasyPlayer < ActiveRecord::Base
  belongs_to :player
  belongs_to :fantasy_team
  belongs_to :fantasy_league

  def to_s
    player.to_s
  end

  def method_missing(m, *args)
    return player.method(m).call(*args) if player.respond_to?(m)
    super
  end
end
