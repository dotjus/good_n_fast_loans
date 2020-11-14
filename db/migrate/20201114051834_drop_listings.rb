class DropListings < ActiveRecord::Migration[6.0]
  def change
    drop_table :listings
  end
end
