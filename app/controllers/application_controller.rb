require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
  end

#Landing Page
  get "/" do
    erb :welcome
  end

#Sign Up Form
  get "/signup" do
    erb :signup
  end

  post "/signup" do
    #if successful, redirect '/home'
    #else, flash error & reload page
  end

#Log In Form
  get "/login" do
    erb :login
  end

  post "/login" do
    #if successful, redirect '/home'
    #else, flash error & reload page
  end

#User Homepage (doubles as User Profile & Dog Index)
  get "/home" do
    erb :home
  end

#Clear Session
  post "/logout" do
  end
  
end
