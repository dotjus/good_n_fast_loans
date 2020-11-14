json.extract! listing, :id, :name, :description, :duration, :cost, :user_id, :address_id, :created_at, :updated_at
json.url listing_url(listing, format: :json)
