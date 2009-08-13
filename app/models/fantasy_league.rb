class FantasyLeague < ActiveRecord::Base
  has_many :fantasy_teams
  has_many :fantasy_players
  has_one :draft

  alias :teams :fantasy_teams

  def draft_sorted_teams
    teams.sort {|x,y| x.draft_order <=> y.draft_order }
  end

  def size
    teams.length
  end

  def undrafted_players
    unless @undrafted_players
      all_players = Player.all
      drafted = drafted_players

      @undrafted_players = Player.sort_by_name(all_players.reject do |p|
        !!drafted.find { |d| d.player.id == p.id }
      end)
    end
    @undrafted_players
  end

  def drafted_players
    Player.sort_by_name(FantasyPlayer.find(:all, {:conditions => ["fantasy_league_id = ?", id]}))
  end
end
