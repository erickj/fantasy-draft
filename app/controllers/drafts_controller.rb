#require 'lib/draft_rules'
$:.push('/home/eejjjj82/ruby/gems/gems/ruleby-0.5/lib')
require 'ruleby'

module DraftRules
  module SelectionRulebooks
    PRIORITY_HIGHEST = 100
    PRIORITY_LOWEST  = 1
  
    class RoundSelectionRulebook < Ruleby::Rulebook
      include CustomLogger
      def rules

        # Select only QB, WR, RB in first 3 rounds
        rule :EarlyRounds, {:priority => PRIORITY_HIGHEST},
             [Draft, :d, m.current_round(&c{ |r| r <= 5 })] do |vars|
log 'retracting non RBs, QBs, WRs'
          engine.facts.find_all do |player|
            player.kind_of?(Player) && ![Player::RB, Player::QB, Player::WR].include?(player.position) 
          end.each do |p|
            retract p
          end
        end #/rule

        rule :MidRounds, {:priority => PRIORITY_HIGHEST},
             [Draft, :d, m.current_round(&c{ |r| r <= 9 })] do |vars|
log 'retracting non RBs, QBs, WRs, TEs'
          engine.facts.find_all do |player|
            player.kind_of?(Player) && ![Player::RB, Player::QB, Player::WR, Player::TE].include?(player.position) 
          end.each do |p|
            retract p
          end
        end #/rule

        # Rank Player Necessity by abundance and round
        rule :RankPlayerNecessityByRound,
             [Draft, :d],
             [Player, :p] do |vars|
          p = vars[:p]
          rnd = vars[:d].current_round
          pos_count_weight = vars[:d].current_team.count_by_pos(p.position)
     
          c = 10
          f = nil

          if pos_count_weight >= (rnd * 0.5) || pos_count_weight >= 4
            f = c * rnd + pos_count_weight
            p.detract_rank(f)
log 'detract rank of %s by %s'%[p,f]
          else
            count_factor = pos_count_weight.zero? ? 2 : 1
            f = c * rnd * count_factor
            p.boost_rank(f)
log 'boost rank of %s by %s'%[p,f]
          end
        end #/rule

        # Elevate RB extra by 3rd round if none
        rule :ElevateRB,
             [Draft, :d, m.current_round(&c{ |rnd| rnd >= 3})],
             [Player, :p, m.rb? == true],
             [FantasyTeam, :t, m.count_rb == 0] do |vars|
          factor = vars[:d].current_round * 15
          vars[:p].boost_rank(factor)
        end #/rule

        # Elevate WR extra by 3rd round if none
        rule :ElevateWR,
             [Draft, :d, m.current_round(&c{ |rnd| rnd >= 3})],
             [Player, :p, m.wr? == true],
             [FantasyTeam, :t, m.count_wr == 0] do |vars|
          factor = vars[:d].current_round * 15
          vars[:p].boost_rank(factor)
        end #/rule

        # Elevate QB extra by 4th round if none
        rule :ElevateQB,
             [Draft, :d, m.current_round(&c{ |rnd| rnd >= 4})],
             [Player, :p, m.qb? == true],
             [FantasyTeam, :t, m.count_qb == 0] do |vars|
          factor = vars[:d].current_round * 15
          vars[:p].boost_rank(factor)
        end #/rule

=begin
        # Require a WR by 5th round
        rule :RequireWRByFourth,
             [Draft, :d, m.current_round == 5],
             [FantasyTeam, :t, m.count_wr == 0] do |vars|
log 'retracting everything but running backs'
          engine.facts.find_all do |player|
            player.kind_of?(Player) && !player.wr?
          end.each do |p|
            retract p
          end
        end #/rule

        # Require a QB by 4th round
        rule :RequireQBByFourth,
             [Draft, :d, m.current_round == 4],
             [FantasyTeam, :t, m.count_qb == 0] do |vars|
log 'retracting everything but quarter backs'
          engine.facts.find_all do |player|
            player.kind_of?(Player) && !player.qb?
          end.each do |p|
            retract p
          end
        end #/rule

        # No more than 1QBs until 1 RB
        rule :NoMoreThanOneQBUntilOneRB,
             [FantasyTeam, :t, m.count_qb(&c{ |rb| rb >= 1}), m.count_rb == 0] do |vars|
log 'retracting quarter backs'
          engine.facts.find_all do |player|
            player.kind_of?(Player) && player.qb?
          end.each do |p|
            retract p
          end
        end #/rule

        # No more than 1QBs until 1 WR
        rule :NoMoreThanOneQBUntilOneWR,
             [FantasyTeam, :t, m.count_qb(&c{ |rb| rb >= 1}), m.count_rb == 0] do |vars|
log 'retracting quarter backs'
          engine.facts.find_all do |player|
            player.kind_of?(Player) && player.qb?
          end.each do |p|
            retract p
          end
        end #/rule

        # No more than 2 RBs until at least 1 WR
        rule :NoMoreThanThreeRBUntilOneWR,
             [FantasyTeam, :t, m.count_rb(&c{ |rb| rb >= 2}), m.count_wr == 0] do |vars|
log 'retracting running backs'
          engine.facts.find_all do |player|
            player.kind_of?(Player) && player.rb?
          end.each do |p|
            retract p
          end
        end #/rule

        # No more than 3 RBs until at least 1 QB
        rule :NoMoreThanFourRBUntilOneQB,
             [FantasyTeam, :t, m.count_rb(&c{ |rb| rb >= 3}), m.count_qb == 0] do |vars|
log 'retracting running backs'
          engine.facts.find_all do |player|
            player.kind_of?(Player) && player.rb?
          end.each do |p|
            retract p
          end
        end #/rule

        # Don't select 2 WRs until at least 1 RB
        rule :NoMoreThanTwoWRUntilOneRB,
             [FantasyTeam, :t, m.count_wr(&c{ |rb| rb >= 1}), m.count_rb == 0] do |vars|
log 'retracting wide receivers'
          engine.facts.find_all do |player|
            player.kind_of?(Player) && player.wr?
          end.each do |p|
            retract p
          end
        end #/rule

        # Don't select 3 WRs until at least 1 QB
        rule :NoMoreThanTwoWRUntilOneQB,
             [FantasyTeam, :t, m.count_wr(&c{ |rb| rb >= 2}), m.count_qb == 0] do |vars|
log 'retracting wide receivers'
          engine.facts.find_all do |player|
            player.kind_of?(Player) && player.wr?
          end.each do |p|
            retract p
          end
        end #/rule

=end

      end
    end
  end
end


class DraftsController < ApplicationController
  include Ruleby
  include CustomLogger
  include DraftRules

  def suggest_selection
    @draft = Draft.find(params[:id])

log "Current Team: %s, ID: %d"%[@draft.current_team.name, @draft.current_team.id]
log @draft.current_team.roster_summary.to_yaml

log "Round: %d"%@draft.current_round


    filter_players = nil
    engine :engine do |e|
      SelectionRulebooks::RoundSelectionRulebook.new(e).rules

      e.assert @draft
      e.assert @draft.current_team
      @draft.available_players.sort { |p1,p2| p1.rank <=> p2.rank }[0,50].each { |p| e.assert p }

      e.match

      filter_players = e.facts.find_all { |fact| fact.kind_of?(Player) }

#log filter_players.to_yaml
      Draft::SelectionSuggestion.instance.player = filter_players.sort do |p1,p2|
log "comparing %s with %s, rank %s vs %s"%[p1,p2,p1.rank.nil?.to_s, p2.rank]
        p2.calculated_rank <=> p1.calculated_rank
      end.first
    end

    log "Suggesting: %s"%Draft::SelectionSuggestion.instance.player
    tpl = <<JS
$('draft_selection_fantasy_player_id').value = %d;
$('suggestion-selection').update('>> %s');
$('top-suggestions').update('%s');
JS

    js = tpl%[Draft::SelectionSuggestion.instance.player.id,
              Draft::SelectionSuggestion.instance.player,
              @draft.available_players.sort { |p1,p2| p2.calculated_rank <=> p1.calculated_rank }[0..19].inject('') do |memo,p|
                memo << "<li>%s - %s</li>"%[p, p.calculated_rank.to_s]
              end
             ]

    render :js => js
  end

  def league_draft
    @draft = Draft.find_or_create_by_league_id(params[:fantasy_league_id])
    @draft_selection = DraftSelection.new

    render :action => "show"
  end

  # GET /drafts
  # GET /drafts.xml
  def index
    @drafts = Draft.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @drafts }
    end
  end

  # GET /drafts/1
  # GET /drafts/1.xml
  def show
    @draft = Draft.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @draft }
    end
  end

  # GET /drafts/new
  # GET /drafts/new.xml
  def new
    @draft = Draft.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @draft }
    end
  end

  # GET /drafts/1/edit
  def edit
    @draft = Draft.find(params[:id])
  end

  # POST /drafts
  # POST /drafts.xml
  def create
    @draft = Draft.new(params[:draft])

    respond_to do |format|
      if @draft.save
        flash[:notice] = 'Draft was successfully created.'
        format.html { redirect_to(@draft) }
        format.xml  { render :xml => @draft, :status => :created, :location => @draft }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @draft.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /drafts/1
  # PUT /drafts/1.xml
  def update
    @draft = Draft.find(params[:id])

    respond_to do |format|
      if @draft.update_attributes(params[:draft])
        flash[:notice] = 'Draft was successfully updated.'
        format.html { redirect_to(@draft) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @draft.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /drafts/1
  # DELETE /drafts/1.xml
  def destroy
    @draft = Draft.find(params[:id])
    @draft.destroy

    respond_to do |format|
      format.html { redirect_to(drafts_url) }
      format.xml  { head :ok }
    end
  end
end
