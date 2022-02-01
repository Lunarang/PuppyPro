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
    @user = User.new(params["user"])
    if @user.valid?
      @user.save
      session[:user_id] = @user.id

      flash[:notice] = "Sign up successful! Welcome to your homepage!"
      redirect '/home'
    else
      #using Active Records error hash for form validation errors
      flash.now[:error] = @user.errors.full_messages
      erb :signup
    end
  end

# Log In Form - GET
  get "/login" do
    erb :login
  end

# Log In Form - POST
  post "/login" do
    @user = User.find_by(email: params["email"])
    if @user && @user.authenticate(params["password"])
      session[:user_id] = @user.id

      redirect to '/home'
    else
      flash.now[:notice] = "Email or Password does not match. Please try again:"
      erb :login
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
      @user = User.find_by(session[:user_id])
    end 

    def verify_user_login
      if logged_in?
        current_user
      else
        redirect '/login'
      end
    end

    def current_path
      Rack::Request.new(env).path_info
    end
  end

end
