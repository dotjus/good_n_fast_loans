json.extract! listing, :id, :name, :description, :duration, :cost, :user_id, :street_number, :street_name, :city, :postcode, :state, :created_at, :updated_at
json.url listing_url(listing, format: :json)
