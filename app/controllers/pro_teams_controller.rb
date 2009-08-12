class ProTeamsController < ApplicationController
  # GET /pro_teams
  # GET /pro_teams.xml
  def index
    @pro_teams = ProTeam.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pro_teams }
    end
  end

  # GET /pro_teams/1
  # GET /pro_teams/1.xml
  def show
    @pro_team = ProTeam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pro_team }
    end
  end

  # GET /pro_teams/new
  # GET /pro_teams/new.xml
  def new
    @pro_team = ProTeam.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pro_team }
    end
  end

  # GET /pro_teams/1/edit
  def edit
    @pro_team = ProTeam.find(params[:id])
  end

  # POST /pro_teams
  # POST /pro_teams.xml
  def create
    @pro_team = ProTeam.new(params[:pro_team])

    respond_to do |format|
      if @pro_team.save
        flash[:notice] = 'ProTeam was successfully created.'
        format.html { redirect_to(@pro_team) }
        format.xml  { render :xml => @pro_team, :status => :created, :location => @pro_team }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pro_team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pro_teams/1
  # PUT /pro_teams/1.xml
  def update
    @pro_team = ProTeam.find(params[:id])

    respond_to do |format|
      if @pro_team.update_attributes(params[:pro_team])
        flash[:notice] = 'ProTeam was successfully updated.'
        format.html { redirect_to(@pro_team) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pro_team.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pro_teams/1
  # DELETE /pro_teams/1.xml
  def destroy
    @pro_team = ProTeam.find(params[:id])
    @pro_team.destroy

    respond_to do |format|
      format.html { redirect_to(pro_teams_url) }
      format.xml  { head :ok }
    end
  end
end
