require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secret'
    use Rack::Flash
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
    #if successful, redirect '/home'... else, flash error
    @user = User.new(params["user"])
    if @user.valid?
      @user.save
      session[:user_id] = @user.id

      redirect '/home'
    else
      #using Active Records error hash for form validation errors
      flash[:error] = @user.errors.full_messages

    end
  end

#Log In Form
  get "/login" do
    flash[:notice]
    erb :login
  end

  post "/login" do
    #if successful, redirect '/home'... else, flash error
    @user = User.find_by(email: params["email"])
    if @user && @user.authenticate(params["password"])
      session[:user_id] = @user.id

      redirect to '/home'
    else
      flash[:notice] = "Email or Password does not match. Please try again:"
      redirect to '/home'
    end
  end

#User Homepage
  get "/home" do
    login_required

    current_user
    erb :home
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
      @user = User.find_by_id(session[:user_id])
    end 

    def login_required
      redirect '/login' unless logged_in?
    end

  end
end
