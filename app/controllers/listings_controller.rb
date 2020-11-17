class ListingsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:pay]

  before_action :set_listing, only: [:show, :edit, :update, :destroy, :pay, :borrow, :borrowed]
  
  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all
    @un_borrowed_listings = []
    @listings.each do |listing|
      if listing.users == []
        @un_borrowed_listings << listing
      end  
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    # if Listing.find(current_user.id).users == nil
    #   @user_borrowing = "8===D"
    # end
    @user_borrowing = User.find(current_user.id).listings
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
    check_edit_permisions
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
        ## Assigns the role of lender to the current user for the item just created.
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


  def borrow
    @user = current_user.id
    # user = current_user
    # @user_id = user.id
  end

  def borrowed

  end

  def pay
    Stripe.api_key = ENV['STRIPE_API_KEY']
    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      mode: 'payment',
      success_url: pay_success_url(params[:id]),
      cancel_url: pay_cancel_url(params[:id]),
      line_items: [
        {
          price_data: {
            currency: 'aud',
            product_data: {
              name: @listing.name
            },
            unit_amount: (@listing.cost * 100).to_i
          },
          quantity: 1
        }
      ]
    })
    render json:session
  end

  def pay_success

    # Link borrower to the item via the joining table Loans
    user_id = current_user.id
    User.find_by(id: user_id).listings << Listing.find(params[:id])

    # Make borrower a borrower in rolify for this item
    @user = current_user
    @user.add_role :borrower, Listing.find(params[:id])

    # Make owner of item the loaner in rolify
    @loaner = Listing.find(params[:id]).user
    @loaner.add_role :loaner, Listing.find(params[:id])

    flash[:alert] = "Congrats on your hire!"

    redirect_to :my_hires
  end

  def pay_cancel

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

    def check_edit_permisions
      if !current_user.has_role?(:lender, @listing)
        flash[:alert] = "You do not have permisions to edit this listing."
        redirect_to root_path
      end
    end
end
