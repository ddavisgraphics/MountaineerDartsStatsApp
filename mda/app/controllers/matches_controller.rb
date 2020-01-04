class MatchesController < ApplicationController
  # before actions
  before_action :set_match, only: [:show, :edit, :update, :destroy]
  
  # includes
  include Stats

  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.all
  end

  def test
  end 

  # GET /matches/1
  # GET /matches/1.json
  def show
  end

  # GET /matches/new
  def new
    @match = Match.new
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)
    respond_to do |format|
      if @match.save
        save_stats(@match, :home)
        save_stats(@match, :away)
        format.html { redirect_to @match, notice: 'Match was successfully created.' }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    respond_to do |format|
      if params[:match][:results].is_a? String
        params[:match][:results] = JSON.parse(params[:match][:results].gsub!('=>', ':'))     
      end
     
      if @match.update(match_params)
        update_stats(@match, :home)
        update_stats(@match, :away)
        format.html { redirect_to @match, notice: 'Match was successfully updated.' }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url, notice: 'Match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # save stats
  def save_stats(match, team)
    stats = Stats::Persist.new(match.results[team], match.week, match.season_id)
    stats.singles_save
    stats.cricket_save
    stats.choice_save
  end

  # update stats
  def update_stats(match, team)
    stats = Stats::Persist.new(match.results[team], match.week, match.season_id)
    stats.singles_update
    stats.cricket_update
    stats.choice_update
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:home_team_id, :away_team_id, :season_id, :week, :results => {})
    end
end
