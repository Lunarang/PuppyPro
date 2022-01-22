require_relative "../config/environment.rb"

mel = User.create(name: "Melissa", email: "melliebellie@gmail.com", password: "mellsbells")
erin = User.create(name: "Erin", email: "erin.smells@gmail.com", password: "password")
steve = User.create(name: "Steve", email: "steviewonder@gmail.com", password: "bucky12")

Dog.create(name: "Dodger", sex: "Female", dob: Date.new(2019, 11, 30), user_id: "#{erin.id}")
Dog.create(name: "Buccaroo", sex: "Male", dob: Date.new(2020, 08, 26), user_id: "#{steve.id}")
Dog.create(name: "Goose", sex: "Male", dob: Date.new(2015, 02, 03), user_id: "#{mel.id}")