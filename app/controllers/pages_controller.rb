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
    @my_loans = Listing.where(user_id: @user.id)

  end

end
