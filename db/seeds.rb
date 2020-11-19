# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).


## User ID's and Listing ID's will be auto generated.

## Creates admin account
admin1 = User.new(
    email: "admin1@admin.com",
    password: "password",
    password_confirmation: "password"
)
admin1.save!

## Creates a default user account
client1 = User.new(
    email: "client1@client.com",
    password: "password",
    password_confirmation: "password"
)
client1.save!

## Creates a second default user account
client2 = User.new(
    email: "client2@client.com",
    password: "password",
    password_confirmation: "password"
)
client2.save!

## Creates a listing of a motor bike.
listing1 = Listing.new(
  name: "Motor Bike", 
  description: "Goes fast.", 
  duration: "1 Month", 
  cost: 0.5e3, 
  user_id: client1.id, 
  street_number: 123, 
  street_name: "abc st", 
  city: "Hoetown", 
  postcode: 1111, 
  state: "QLD",
  image: {
      io: File.open("app/assets/images/bike.jpg"),
      filename: "bike.jpg",
      content_type: "image/jpg",
      identify: false
    }
)
listing1.save!

## Creates a listing of a pool table.
listing2 = Listing.new(
  name: "Pool Table", 
  description: "Do things on it.", 
  duration: "1 Week", 
  cost: 0.5e2, 
  user_id: client1.id, 
  street_number: 123, 
  street_name: "abc st", 
  city: "Apocalypse Peaks", 
  postcode: 2222, 
  state: "QLD",
  image: {
      io: File.open("app/assets/images/pooltable.jpg"),
      filename: "pooltable.jpg",
      content_type: "image/jpg",
      identify: false
    }
)
listing2.save!

## Creates a listing of an ice cream.
listing3 = Listing.new(
  name: "Ice Cream", 
  description: "Yup you can lick it. But you must return it.", 
  duration: "1 day", 
  cost: 0.1e2, 
  user_id: client2.id, 
  street_number: 123, 
  street_name: "abc st", 
  city: "Tra-La-La-Laa", 
  postcode: 4444, 
  state: "NSW",
  image: {
      io: File.open("app/assets/images/icecream.jpg"),
      filename: "icecream.jpg",
      content_type: "image/jpg",
      identify: false
    }
)
listing3.save!

## Makes the admin account owner of all listings made now and in the future.
admin1.add_role :lender

## Makes the client1 account owner of listings 1 & 2
client1.add_role :lender, listing1
client1.add_role :lender, listing2

## Makes the client2 account owner of listings 3
client2.add_role :lender, listing3