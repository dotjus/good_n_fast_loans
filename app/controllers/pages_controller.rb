class PagesController < ApplicationController
  def home
  end

  def my_listings
    @listings = Listing.all
    @user = current_user
  end

  def my_hires
    @listings = Listing.all
    @user = current_user
  end

end
