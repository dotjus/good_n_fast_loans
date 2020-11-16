class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    check_signed_in
    @user = current_user
    @listing = Listing.new
    

  end

  # GET /listings/1/edit
  def edit
    check_signed_in
    @user = current_user
  end

  # POST /listings
  # POST /listings.json
  def create
    check_signed_in
    @user = current_user
    @listing = Listing.new(listing_params)


    respond_to do |format|
      if @listing.save
        @user.add_role :lender, Listing.last
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    @user = current_user
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    check_signed_in

    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def listing_params
      params.require(:listing).permit(:name, :description, :duration, :cost, :user_id, :street_number, :street_name, :city, :postcode, :state, :image)
    end

    def check_signed_in
      if !user_signed_in?
        flash[:alert] = "Please sign up to create and edit your own listings."
        redirect_to new_user_registration_path
      end
    end
end
