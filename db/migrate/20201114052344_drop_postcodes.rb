class DropPostcodes < ActiveRecord::Migration[6.0]
  def change
    drop_table :postcodes
  end
end
