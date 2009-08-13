class Draft < ActiveRecord::Base

  class SelectionSuggestion
    include Singleton
    attr_accessor :player
  end

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

  def available_players
    league.undrafted_players
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

  def teams_by_round(round=nil)
    round ||= current_round
    round.even? ? teams.reverse : teams
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
    round_from_overall_pick(current_overall_selection)
  end

  def current_pick
    pick_from_overall_pick(current_overall_selection)
  end

  def current_team
    teams_by_round[current_pick - 1]
  end

  def next_team(inc=1)
    next_round = round_from_overall_pick(current_overall_selection + inc)
    next_round_pick = pick_from_overall_pick(current_overall_selection + inc)

    teams_by_round(next_round)[next_round_pick - 1]
  end

  def last_pick
    last = current_overall_selection - 1
    team = nil
    team = selection(round_from_overall_pick(last), pick_from_overall_pick(last)) unless last < 1
    team
  end

  def round_from_overall_pick(overall)
    (overall.to_f / picks_per_round.to_f).ceil
  end

  def pick_from_overall_pick(overall)
    round = round_from_overall_pick(overall)
    ((round - 1) * picks_per_round - overall).abs
  end

end
