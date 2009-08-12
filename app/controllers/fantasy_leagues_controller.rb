class FantasyLeaguesController < ApplicationController
  # GET /fantasy_leagues
  # GET /fantasy_leagues.xml
  def index
    @fantasy_leagues = FantasyLeague.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fantasy_leagues }
    end
  end

  # GET /fantasy_leagues/1
  # GET /fantasy_leagues/1.xml
  def show
    @fantasy_league = FantasyLeague.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fantasy_league }
    end
  end

  # GET /fantasy_leagues/new
  # GET /fantasy_leagues/new.xml
  def new
    @fantasy_league = FantasyLeague.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fantasy_league }
    end
  end

  # GET /fantasy_leagues/1/edit
  def edit
    @fantasy_league = FantasyLeague.find(params[:id])
  end

  # POST /fantasy_leagues
  # POST /fantasy_leagues.xml
  def create
    @fantasy_league = FantasyLeague.new(params[:fantasy_league])

    respond_to do |format|
      if @fantasy_league.save
        flash[:notice] = 'FantasyLeague was successfully created.'
        format.html { redirect_to(@fantasy_league) }
        format.xml  { render :xml => @fantasy_league, :status => :created, :location => @fantasy_league }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fantasy_league.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fantasy_leagues/1
  # PUT /fantasy_leagues/1.xml
  def update
    @fantasy_league = FantasyLeague.find(params[:id])

    respond_to do |format|
      if @fantasy_league.update_attributes(params[:fantasy_league])
        flash[:notice] = 'FantasyLeague was successfully updated.'
        format.html { redirect_to(@fantasy_league) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fantasy_league.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fantasy_leagues/1
  # DELETE /fantasy_leagues/1.xml
  def destroy
    @fantasy_league = FantasyLeague.find(params[:id])
    @fantasy_league.destroy

    respond_to do |format|
      format.html { redirect_to(fantasy_leagues_url) }
      format.xml  { head :ok }
    end
  end
end
