class DraftSelectionsController < ApplicationController
  # GET /draft_selections
  # GET /draft_selections.xml
  def index
    @draft_selections = DraftSelection.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @draft_selections }
    end
  end

  # GET /draft_selections/1
  # GET /draft_selections/1.xml
  def show
    @draft_selection = DraftSelection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @draft_selection }
    end
  end

  # GET /draft_selections/new
  # GET /draft_selections/new.xml
  def new
    @draft_selection = DraftSelection.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @draft_selection }
    end
  end

  # GET /draft_selections/1/edit
  def edit
    @draft_selection = DraftSelection.find(params[:id])
  end

  # POST /draft_selections/write_in
  def write_in(player)
    p = Player.new(player)
    p.save
    p
  end

  # POST /draft_selections
  # POST /draft_selections.xml
  def create
    if params[:write_in]
      player = write_in(params[:write_in])
      params[:draft_selection][:fantasy_player_id] = player.id
    end

    @draft_selection = DraftSelection.new(params[:draft_selection])

    draft = Draft.find(@draft_selection.draft_id)

    @fantasy_player = FantasyPlayer.new({
      :fantasy_team_id => @draft_selection.fantasy_team_id,
      :fantasy_league_id => draft.league.id,
      :player_id => @draft_selection.fantasy_player_id
    })

    respond_to do |format|
      if @draft_selection.save
        @fantasy_player.save
        flash[:notice] = '%s was successfully drafted.'%@fantasy_player.name

        redirect_to fantasy_league_draft_url(@fantasy_player.fantasy_league_id)
        return

        format.html { redirect_to(@draft_selection) }
        format.xml  { render :xml => @draft_selection, :status => :created, :location => @draft_selection }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @draft_selection.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /draft_selections/1
  # PUT /draft_selections/1.xml
  def update
    @draft_selection = DraftSelection.find(params[:id])

    respond_to do |format|
      if @draft_selection.update_attributes(params[:draft_selection])
        flash[:notice] = 'DraftSelection was successfully updated.'
        format.html { redirect_to(@draft_selection) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @draft_selection.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /draft_selections/1
  # DELETE /draft_selections/1.xml
  def destroy
    @draft_selection = DraftSelection.find(params[:id])
    league_id = @draft_selection.fantasy_player.fantasy_league_id
    name = @draft_selection.name
  
    @draft_selection.fantasy_player.destroy
    @draft_selection.destroy

    respond_to do |format|
      flash[:notice] = "The '%s' pick has been undone"%name
      return redirect_to fantasy_league_draft_url(league_id)
      format.html { redirect_to(draft_selections_url) }
      format.xml  { head :ok }
    end
  end
end
