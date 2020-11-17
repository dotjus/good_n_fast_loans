class PagesController < ApplicationController
  def home
  end

  def my_listings
    @listings = Listing.all
    @user = current_user
  end

  def my_hires
    @user = current_user
    @my_borrowing = @user.listings
    @my_listings = User.find(current_user.id).listings


    @my_loans = []
    @listings = Listing.all
    @listings.each do |listing|
      if @user.has_role? :loaner, listing
        @my_loans << listing
      end
    end



    # @listings.each do |listing|
    #     if listing.user == current_user
    #       @my_listings << listing
    #     end
    # end
    # @my_listings.each do |my_listing|
    #     if my_listing.user.has_role? :loaner, my_listing
    #       @my_loans << my_listing
    #     end
    # end 

  end

end
