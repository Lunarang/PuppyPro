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
    #if successful, redirect '/home'... else, flash error & reload page
    @user = User.new(params["user"])
    if @user.valid?
      @user.save
      session[:user_id] = @user.id

      redirect '/home'
    else
      @errors = @user.errors.full_messages
      erb :signup
    end
  end

#Log In Form
  get "/login" do
    erb :login
  end

  post "/login" do
    #if successful, redirect '/home'... else, flash error & reload page
    @user = User.find_by(email: params["email"])
    if @user && @user.authenticate(params["password"])
      session[:user_id] = @user.id

      redirect to '/home'
    else
      @errors = @user.errors.full_messages
      erb :login
    end
  end

#User Homepage
  get "/home" do
    @user = current_user
    if logged_in?
      erb :home
    else
      redirect '/login'
    end
  end

#Clear Session
  post "/logout" do
    session.clear
    redirect '/'
  end
  
#Controller Helpers
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find_by_id(session[:user_id])
    end 

  end
end
