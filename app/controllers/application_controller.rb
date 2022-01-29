require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
    use Rack::Flash
  end

# Landing Page
  get "/" do
    erb :welcome
  end

# Sign Up Form - GET
  get "/signup" do
    erb :signup
  end

# Sign Up Form - POST
  post "/signup" do
    #if successful, redirect '/home'... else, flash error
    @user = User.new(params["user"])
    if @user.valid?
      @user.save
      session[:user_id] = @user.id

      redirect '/home'
    else
      #using Active Records error hash for form validation errors
      flash[:error] = @user.errors.full_messages
      redirect '/signup'
    end
  end

# Log In Form - GET
  get "/login" do
    erb :login
  end

# Log In Form - POST
  post "/login" do
    #if successful, redirect '/home'... else, flash error
    @user = User.find_by(email: params["email"])
    if @user && @user.authenticate(params["password"])
      session[:user_id] = @user.id

      redirect to '/home'
    else
      flash[:notice] = "Email or Password does not match. Please try again:"
      redirect to '/login'
    end
  end

# User Homepage
  get "/home" do
    verify_user_login

    erb :home
  end

# User Skill Library
  get "/library" do
    verify_user_login

    erb :library
  end

# Clear Session
  get "/logout" do
    session.clear
    redirect '/'
  end
  
# Controller Helpers
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find_by_id(session[:user_id])
    end 

    def verify_user_login
      if logged_in?
        @user = current_user
      else
        redirect '/login'
      end
      @user
    end

  end
end
