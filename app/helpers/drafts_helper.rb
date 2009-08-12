module DraftsHelper
  def player_select(f, draft)
    players = draft.league.undrafted_players
    f.select(:fantasy_player_id, players.map { |p| ["%s - %s"%[p.reverse_name,p.team.name], p.id] })
  end

  def is_current_pick?(draft, team, idx)
    is_current_round?(draft, idx) && draft.current_team == team
  end

  def is_current_round?(draft, idx)
    idx+1 == draft.current_round
  end
end
