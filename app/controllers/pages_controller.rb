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

    @my_loans = User.find(current_user.id).listings
  end

 

end
