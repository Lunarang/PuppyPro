class UsersController < ApplicationController

# Index
    get "/users" do
        erb :"/users/index"
    end

# New (Create.R.U.D) - GET/POST in Application_Controller
    get "/user/new" do
        redirect "/signup"
    end

# Show (C.Read.U.D)
    get "/users/:id" do
        current_user
        @shown_user = User.find(params[:id])

        erb :"users/show"
    end

# Edit (C.R.Update.D) - GET
    get "/users/:id/edit" do
        verify_user_login
        @shown_user = User.find(params[:id])

        if @user.id == @shown_user.id
            erb :"/users/edit"
        else
            flash[:notice] = "You can only edit your own profile!"
            redirect to "/users/#{@shown_user.id}"
        end
    end

# Edit (C.R.Update.D) - PATCH
    patch "/users/:id" do
        verify_user_login
        @shown_user = User.find(params[:id])

        if @user.id == @shown_user.id
            @user.update(params["user"])
            flash[:notice] = "Your profile has been updated!"
        else
            flash[:notice] = "You can only edit your own profile!"
        end

        redirect to "/users/#{@shown_user.id}"
    end

# Delete (C.R.U.Destroy)
    delete "/users/:id" do
        verify_user_login
        @shown_user = User.find(params[:id])

        if @user.id == @shown_user.id
            user.destroy_all
            flash[:notice] = "Your profile has been deleted..."
            redirect to "/"
        else
            flash[:notice] = "You can only delete your own account!"
            redirect to "/users/#{@shown_user.id}"
        end
    end

end
        