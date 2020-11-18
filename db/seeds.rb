# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.new(
    id: 101,
    email: "admin01@admin.com",
    password: "password",
    password_confirmation: "password"
)
admin.save!

client1 = User.new(
    id: 102,
    email: "client01@client.com",
    password: "password",
    password_confirmation: "password"
)
client1.save!

client2 = User.new(
    id: 103,
    email: "client02@client.com",
    password: "password",
    password_confirmation: "password"
)
client2.save!

Listing.create!([
    {
    id: 101, 
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
    # image: Rails.root.join("app/assets/images/bike.jpg")
    },

    {
    id: 102, 
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
    # image: Rails.root.join("app/assets/images/pooltable.jpg")
    },

    {
    id: 103, 
    name: "Ice Cream", 
    description: "Yup you can lick it.", 
    duration: "1 day", 
    cost: 0.1e2, 
    user_id: client2.id, 
    street_number: 123, 
    street_name: "abc st", 
    city: "Alberta", 
    postcode: 4444, 
    state: "NSW",
    # image: Rails.root.join("app/assets/images/icecream.jpg")
    }
])