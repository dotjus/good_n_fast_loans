class Listing < ApplicationRecord
  resourcify
  belongs_to :user
  has_one_attached :image
  
end
