class FantasyPlayer < ActiveRecord::Base
  belongs_to :player
  belongs_to :fantasy_team
  belongs_to :fantasy_league

  def to_s
    player.to_s
  end

  def name
    player.name
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
end
