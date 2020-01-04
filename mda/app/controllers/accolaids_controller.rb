class AccolaidsController < ApplicationController
  before_action :set_accolaid, only: [:show, :edit, :update, :destroy]

  # GET /accolaids
  # GET /accolaids.json
  def index
    @accolaids = Accolaid.all
  end

  # GET /accolaids/1
  # GET /accolaids/1.json
  def show
  end

  # GET /accolaids/new
  def new
    @accolaid = Accolaid.new
  end

  # GET /accolaids/1/edit
  def edit
  end

  # POST /accolaids
  # POST /accolaids.json
  def create
    @accolaid = Accolaid.new(accolaid_params)

    respond_to do |format|
      if @accolaid.save
        format.html { redirect_to @accolaid, notice: 'Accolaid was successfully created.' }
        format.json { render :show, status: :created, location: @accolaid }
      else
        format.html { render :new }
        format.json { render json: @accolaid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accolaids/1
  # PATCH/PUT /accolaids/1.json
  def update
    respond_to do |format|
      if @accolaid.update(accolaid_params)
        format.html { redirect_to @accolaid, notice: 'Accolaid was successfully updated.' }
        format.json { render :show, status: :ok, location: @accolaid }
      else
        format.html { render :edit }
        format.json { render json: @accolaid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accolaids/1
  # DELETE /accolaids/1.json
  def destroy
    @accolaid.destroy
    respond_to do |format|
      format.html { redirect_to accolaids_url, notice: 'Accolaid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accolaid
      @accolaid = Accolaid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accolaid_params
      params.require(:accolaid).permit(:season_id, :player_id, :accolaid, :number, :week)
    end
end
