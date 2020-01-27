class SeasonStandingsController < ApplicationController
  before_action :set_season_standing, only: [:show, :edit, :update, :destroy]

  # GET /season_standings
  # GET /season_standings.json
  def index
    queryStandings = SeasonStanding.all
    standings = []
    queryStandings.each do |standing|
      tmp_hash = {}
      tmp_hash[:id] = standing.id
      tmp_hash[:team] = standing.team.name
      tmp_hash[:season] = standing.season.name
      tmp_hash[:division] = standing.division
      tmp_hash[:wins] = standing.wins
      tmp_hash[:losses] = standing.losses
      tmp_hash[:points] = standing.points
      standings << tmp_hash
    end 
    @season_standings = standings.sort_by { |k| k[:division] }
  end

  def generate
    season = params[:season]
    Team.all.each do |team|
      SeasonStanding.create(team_id: team.id, season_id: season, wins:0, losses:0, points:0)
    end
    redirect_to season_standings_url, notice: 'Season Standings have been generated!'
  end

  # GET /season_standings/1
  # GET /season_standings/1.json
  def show
  end

  # GET /season_standings/new
  def new
    @season_standing = SeasonStanding.new
  end

  # GET /season_standings/1/edit
  def edit
  end

  # POST /season_standings
  # POST /season_standings.json
  def create
    @season_standing = SeasonStanding.new(season_standing_params)

    respond_to do |format|
      if @season_standing.save
        format.html { redirect_to @season_standing, notice: 'Season standing was successfully created.' }
        format.json { render :show, status: :created, location: @season_standing }
      else
        format.html { render :new }
        format.json { render json: @season_standing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /season_standings/1
  # PATCH/PUT /season_standings/1.json
  def update
    respond_to do |format|
      if @season_standing.update(season_standing_params)
        format.html { redirect_to @season_standing, notice: 'Season standing was successfully updated.' }
        format.json { render :show, status: :ok, location: @season_standing }
      else
        format.html { render :edit }
        format.json { render json: @season_standing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /season_standings/1
  # DELETE /season_standings/1.json
  def destroy
    @season_standing.destroy
    respond_to do |format|
      format.html { redirect_to season_standings_url, notice: 'Season standing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_season_standing
      @season_standing = SeasonStanding.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def season_standing_params
      params.require(:season_standing).permit(:team_id, :season_id, :wins, :losses, :points)
    end
end
