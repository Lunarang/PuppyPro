require_relative "../config/environment.rb"

mel = User.create(name: "Melissa", email: "melliebellie@gmail.com", password: "mellsbells")
erin = User.create(name: "Erin", email: "erin.smells@gmail.com", password: "password")
steve = User.create(name: "Steve", email: "steviewonder@gmail.com", password: "bucky12")

Dog.create(name: "Dodger", sex: "female", dob: Date.new(2019, 11, 30), user_id: "#{erin.id}")
Dog.create(name: "Buccaroo", sex: "male", dob: Date.new(2020, 8, 26), user_id: "#{steve.id}")
Dog.create(name: "Goose", sex: "male", dob: Date.new(2015, 2, 3), user_id: "#{mel.id}")