class Listing < ApplicationRecord
  resourcify
  belongs_to :user
  has_many :loans
  has_many :users, through: :loans
  has_one_attached :image

  validates :name, :description, :duration, :cost, :street_number, :street_name, :city, :postcode, :state, presence: true

end
