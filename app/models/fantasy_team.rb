class FantasyTeam < ActiveRecord::Base
  belongs_to :fantasy_league
  has_many :fantasy_players

  alias :league :fantasy_league
  alias :roster :fantasy_players

  def running_backs
    roster.find_all { |p| p.rb? }
  end

  def have_rb?(pos)
    running_backs.length > 0
  end

  def quarter_backs
    roster.find_all { |p| p.qb? }
  end

  def wide_receivers
    roster.find_all { |p| p.wr? }
  end

  def tight_ends
    roster.find_all { |p| p.te? }
  end

  def kickers
    roster.find_all { |p| p.k? }
  end

  def def
    roster.find_all { |p| p.d? }
  end

end
