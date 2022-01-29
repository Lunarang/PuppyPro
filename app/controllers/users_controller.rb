class UsersController < ApplicationController

# Index
    get "/users" do
        erb :"/users/index"
    end

# New (Create.R.U.D) - GET/POST in Application_Controller
    get "/users/new" do
        redirect "/signup"
    end

# Show (C.Read.U.D)
    get "/users/:id" do
        current_user
        @shown_user = User.find(params[:id])

        erb :"users/show"
    end

# Edit (C.R.Update.D) - GET
    get "users/:id/edit" do
        verify_user_login
        @shown_user = User.find(params[:id])

        if @user.id == @shown_user.id
            erb :"/skills/edit"
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
            
            skill_list = []
            params["userskills"]["skill_ids"].each do |skill_id|
                id = skill_id.to_i
                skill_list << id
            end

            skill_list.each do |id|
            
                skill = Skill.find_by(id: id)

                if !skill_list.include?(skill.id) && @user.skills.include?(skill)
                    UserSkill.find_by(skill_id: id, user_id: @user.id).destroy_all
                elsif !@user.skills.include?(skill)
                    UserSkill.create(skill_id: skill.id, user_id: @user.id)
                end

            end
        else
            flash[:notice] = "You can only edit your own profile!"
        end

        redirect to "/users/#{@shown_user.id}"
    end

# Delete (C.R.U.Destroy)
    delete "/user/:id" do
        verify_user_login
        @shown_user = User.find(params[:id])

        if @user.id == @shown_user.id
            user.destroy_all
            redirect to "/"
        else
            flash[:notice] = "You can only delete your own account!"
            redirect to "/users/#{@shown_user.id}"
        end
    end

end
        