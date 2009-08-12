class Draft < ActiveRecord::Base
  ROUNDS = 14
  SELECTION_OFFSET = 1

  belongs_to :fantasy_league
  has_many :draft_selections

  alias :league :fantasy_league

  class << self
    def find_or_create_by_league_id(id)
      d = self.find(:first, {:conditions => ["fantasy_league_id = ?", id]})
      d = self.create({:fantasy_league_id => id}) unless d
      d
    end
  end

  def selection(round, pick)
    @selections ||= draft_selections.all

    res = @selections.find do |sel|
      sel.round.to_s == round.to_s && sel.pick.to_s == pick.to_s
    end
  end

  def teams
    league.draft_sorted_teams
  end

  def teams_by_round
    current_round.even? ? teams.reverse : teams
  end

  def total_rounds
    ROUNDS
  end

  def picks_per_round
    teams.length
  end

  def current_overall_selection
    self.draft_selections.count + SELECTION_OFFSET
  end

  def current_round
    sel = current_overall_selection
    (sel.to_f / picks_per_round.to_f).ceil
  end

  def current_pick
    sel = current_overall_selection
    ((current_round - 1) * picks_per_round - current_overall_selection).abs
  end

  def current_team
    teams_by_round[current_pick - 1]
  end

end
