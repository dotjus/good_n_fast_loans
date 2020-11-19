class Listing < ApplicationRecord
  resourcify
  belongs_to :user
  has_many :loans
  has_many :users, through: :loans
  has_one_attached :image
end
