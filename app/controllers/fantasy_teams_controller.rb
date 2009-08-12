class FantasyTeamsController < ApplicationController
  # GET /fantasy_teams
  # GET /fantasy_teams.xml
  def index
    @fantasy_teams = FantasyTeam.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fantasy_teams }
    end
  end

  # GET /fantasy_teams/1
  # GET /fantasy_teams/1.xml
  def show
    @fantasy_team = FantasyTeam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fantasy_team }
    end
  end

  # GET /fantasy_teams/new
  # GET /fantasy_teams/new.xml
  def new
    @fantasy_team = FantasyTeam.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fantasy_team }
    end
  end

  # GET /fantasy_teams/1/edit
  def edit
    @fantasy_team = FantasyTeam.find(params[:id])
  end

  # POST /fantasy_teams
  # POST /fantasy_teams.xml
  def create
    @fantasy_team = FantasyTeam.new(params[:fantasy_team])

    respond_to do |format|
      if @fantasy_team.save
        flash[:notice] = 'FantasyTeam was successfully created.'
        format.html { redirect_to(@fantasy_team) }
        format.xml  { render :xml => @fantasy_team, :status => :created, :location => @fantasy_team }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fantasy_team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fantasy_teams/1
  # PUT /fantasy_teams/1.xml
  def update
    @fantasy_team = FantasyTeam.find(params[:id])

    respond_to do |format|
      if @fantasy_team.update_attributes(params[:fantasy_team])
        flash[:notice] = 'FantasyTeam was successfully updated.'
        format.html { redirect_to(@fantasy_team) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fantasy_team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fantasy_teams/1
  # DELETE /fantasy_teams/1.xml
  def destroy
    @fantasy_team = FantasyTeam.find(params[:id])
    @fantasy_team.destroy

    respond_to do |format|
      format.html { redirect_to(fantasy_teams_url) }
      format.xml  { head :ok }
    end
  end
end
