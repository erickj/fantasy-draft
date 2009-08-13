class Player < ActiveRecord::Base
  QB = "QB"
  RB = "RB"
  WR = "WR"
  TE = "TE"
  D  = "D"
  K  = "K"

  belongs_to :pro_team

  alias :team :pro_team

  class << self
    def positions
      [RB, QB, WR, TE, D, K]
    end

    def sort_by_name(list)
      list.sort do |x,y|
        x.reverse_name <=> y.reverse_name
      end
    end
  end

  def to_s
    "%s (%s) - %s"%[reverse_name, position, team.id]
  end

  def reverse_name
    person_pattern = /^([^\s]*)[\s]+(.*)$/
    defense_pattern = /(.*)D\/ST$/
 
    case name
    when defense_pattern
      name
    when person_pattern
      "%s, %s"%[$2, $1]
    else
      name
    end
  end

  def is_position?(pos)
    position == pos
  end

  def qb?
    is_position?(QB)
  end

  def rb?
    is_position?(RB)
  end

  def wr?
    is_position?(WR)
  end

  def k?
    is_position?(K)
  end

  def d?
    is_position?(D)
  end

  def te?
    is_position?(TE)
  end
end
