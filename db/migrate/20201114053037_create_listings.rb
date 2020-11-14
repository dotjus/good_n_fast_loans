class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string :name
      t.text :description
      t.string :duration
      t.decimal :cost
      t.references :user, null: false, foreign_key: true
      t.integer :street_number
      t.string :street_name
      t.string :city
      t.integer :postcode
      t.string :state

      t.timestamps
    end
  end
end
