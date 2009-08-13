$:.push('/home/eejjjj82/ruby/gems/gems/ruleby-0.5/lib')
require 'ruleby'

module CustomLogger
  def log(*args)
    RAILS_DEFAULT_LOGGER.method(:debug).call(*args)
  end
end

class DraftsController < ApplicationController
  include Ruleby
  include CustomLogger

  module SelectionRulebooks
    PRIORITY_HIGHEST = 100
    PRIORITY_LOWEST  = 1
  
    class RoundSelectionRulebook < Ruleby::Rulebook
      include CustomLogger
      def rules
        rule :EarlyRounds, {:priority => PRIORITY_HIGHEST}, 
             [Draft, :d, m.current_round(&c{ |r| r <= 4 })] do |vars|
          engine.facts.find_all do |player|
            player.kind_of?(Player) && ![Player::RB, Player::QB, Player::WR].include?(player.position) 
          end.each do |p|
            log "retracting %s (%s)"%[p.name,p.position]
            retract p
          end
        end #/rule

        rule :MiddleRounds, {:priority => PRIORITY_HIGHEST}, 
             [Draft, :d, m.current_round(&c{ |r| r > 4 && r <= 9})] do |vars|
          log "Is middle rounds"
        end #/rule

      end
    end

    class TeamRosterRulebook < Ruleby::Rulebook
      def rules
        rule :NeedRBBySecondRound,
             [Draft, :d, m.current_round == 2],
             [:not, FantasyTeam, :t, m.have_rb?] do |vars|
          engine.facts.find_all do |player|
            player.kind_of?(Player) && !player.rb?
          end.each do |p|
            log "retracting %s (%s)"%[p.name,p.position]
            retract p
          end
        end #/rule
      end
    end
  end

  def suggest_selection
    @draft = Draft.find(params[:id])

    filter_players = nil
    engine :engine do |e|
      SelectionRulebooks::RoundSelectionRulebook.new(e).rules

      e.assert @draft
      @draft.available_players.each { |p| e.assert p }

      e.match

      filter_players = e.facts.find_all { |fact| fact.kind_of?(Player) }
      Draft::SelectionSuggestion.instance.player = filter_players.sort do |p1,p2|
        p1.rank <=> p2.rank
      end.first
    end

    log "There are %d players remaining"%@draft.available_players.length
    log "QB: %d"%@draft.available_players.find_all { |p| p.qb? }.length
    log "RB: %d"%@draft.available_players.find_all { |p| p.rb? }.length
    log "WR: %d"%@draft.available_players.find_all { |p| p.wr? }.length
    log "TE: %d"%@draft.available_players.find_all { |p| p.te? }.length
    log "K: %d"%@draft.available_players.find_all { |p| p.k? }.length
    log "D: %d"%@draft.available_players.find_all { |p| p.d? }.length

    log "There are %d players remaining after filtration"%filter_players.length
    log "QB: %d"%filter_players.find_all { |p| p.qb? }.length
    log "RB: %d"%filter_players.find_all { |p| p.rb? }.length
    log "WR: %d"%filter_players.find_all { |p| p.wr? }.length
    log "TE: %d"%filter_players.find_all { |p| p.te? }.length
    log "K: %d"%filter_players.find_all { |p| p.k? }.length
    log "D: %d"%filter_players.find_all { |p| p.d? }.length
  
    render :update do |page|
      page.alert('I suggest: %s'%Draft::SelectionSuggestion.instance.player.name );
    end
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
