class FantasyTeam < ActiveRecord::Base
  belongs_to :fantasy_league
  has_many :fantasy_players

  alias :league :fantasy_league
  alias :roster :fantasy_players

  def running_backs
    roster.find_all { |p| p.rb? }
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

  def defense
    roster.find_all { |p| p.d? }
  end

  def count_rb
    running_backs.length
  end

  def count_qb
    quarter_backs.length
  end

  def count_wr
    wide_receivers.length
  end

  def count_te
    tight_ends.length
  end

  def count_k
    k.length
  end

  def count_d
    defense.length
  end

  def have_rb?(count=1)
    count >= count_rb
  end

  def have_qb?(count=1)
    count >= count_qb
  end

  def have_wr?(count=1)
    count >= count_wr
  end

  def have_te?(count=1)
    count >= count_te
  end

  def have_k?(count=1)
    count >= count_k
  end

  def have_d?(count=1)
    count >= count_d
  end

  def count_by_pos(pos)
    roster.find_all { |p| p.position == pos }.length
  end

  def roster_summary
    {:qb => quarter_backs,
     :rb => running_backs,
     :wr => wide_receivers,
     :te => tight_ends,
     :k => kickers,
     :d => defense
    }
  end
end
