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
        @user = User.find(params[:id])

        erb :"users/show"
    end

# Edit (C.R.Update.D) - GET
    get "users/:id/edit" do
        login_required
        user = User.find(params[:id])

        if current_user.id == user.id
            erb :"/skills/edit"
        else
            flash[:notice] = "You can only edit your own profile!"
            redirect to "/home"
        end
    end

# Edit (C.R.Update.D) - PATCH
    patch "/users/:id" do
        login_required

        current_user.update(params["user"])
        
        skill_list = []
        params["userskills"]["skill_ids"].each do |skill_id|
            id = skill_id.to_i
            skill_list << id
        end

        skill_list.each do |id|
        
            skill = Skill.find_by(id: id)

            if !skill_list.include?(skill.id) && current_user.skills.include?(skill)
                UserSkill.find_by(skill_id: id, user_id: current_user.id).destroy_all
            elsif !current_user.skills.include?(skill)
                UserSkill.create(skill_id: skill.id, user_id: current_user.id)
            end

        end

        redirect to "/home"
    end

# Delete (C.R.U.Destroy)
    delete "/user/:id" do
        login_required
        user = User.find(params[:id])

        if current_user.id == user.id
            user.destroy_all
        end

        redirect to "/welcome"
    end
end
        