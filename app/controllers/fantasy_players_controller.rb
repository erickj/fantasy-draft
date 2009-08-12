class FantasyPlayersController < ApplicationController
  # GET /fantasy_players
  # GET /fantasy_players.xml
  def index
    @fantasy_players = FantasyPlayer.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fantasy_players }
    end
  end

  # GET /fantasy_players/1
  # GET /fantasy_players/1.xml
  def show
    @fantasy_player = FantasyPlayer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fantasy_player }
    end
  end

  # GET /fantasy_players/new
  # GET /fantasy_players/new.xml
  def new
    @fantasy_player = FantasyPlayer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fantasy_player }
    end
  end

  # GET /fantasy_players/1/edit
  def edit
    @fantasy_player = FantasyPlayer.find(params[:id])
  end

  # POST /fantasy_players
  # POST /fantasy_players.xml
  def create
    @fantasy_player = FantasyPlayer.new(params[:fantasy_player])

    respond_to do |format|
      if @fantasy_player.save
        flash[:notice] = 'FantasyPlayer was successfully created.'
        format.html { redirect_to(@fantasy_player) }
        format.xml  { render :xml => @fantasy_player, :status => :created, :location => @fantasy_player }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fantasy_player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fantasy_players/1
  # PUT /fantasy_players/1.xml
  def update
    @fantasy_player = FantasyPlayer.find(params[:id])

    respond_to do |format|
      if @fantasy_player.update_attributes(params[:fantasy_player])
        flash[:notice] = 'FantasyPlayer was successfully updated.'
        format.html { redirect_to(@fantasy_player) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fantasy_player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fantasy_players/1
  # DELETE /fantasy_players/1.xml
  def destroy
    @fantasy_player = FantasyPlayer.find(params[:id])
    @fantasy_player.destroy

    respond_to do |format|
      format.html { redirect_to(fantasy_players_url) }
      format.xml  { head :ok }
    end
  end
end
