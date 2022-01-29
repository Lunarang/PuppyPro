class SkillsController < ApplicationController

# Index
    get "/skills" do
        redirect '/library'
    end

# New (Create.R.U.D) - GET
    get "/skills/new" do
        login_required

        erb :"/skills/new"
    end

# New (Create.R.U.D) - POST
    post "/skills/new" do
        login_required
        current_user
        @skill = Skill.new(params["skill"])

        if @skill.valid?
            @skill.save
            params["dogskill"].each do |dog_id|
                id = dog_id.to_i
                DogSkill.find_by(skill_id: @skill.id, dog_id: id).update(level: params["dogskill"]["#{id}"])
            end

        else
            flash[:error] = @skill.errors.full_messages

        end
    end
    
# Show (C.Read.U.D)
    get "/skills/:id" do
        current_user
        @skill = Skill.find(params[:id])

        erb :"skills/show"
    end

# Edit (C.R.Update.D) - GET
    get "skills/:id/edit" do
        login_required
        @skill = Skill.find(params[:id])

        if @skill.user_id == current_user.id
            erb :"/skills/edit"
        else
            flash[:notice] = "You can only edit that belong to your own library!"
            redirect to "/skills/#{@skills.id}"
        end
    end

# Edit (C.R.Update.D) - PATCH
    patch "/skills/:id" do
        login_required

        @skill = Skill.find(params[:id])
        @skill.update(params["skill"])
     
        params["dogskill"].each do |dog_id|
            id = dog_id.to_i
            DogSkill.find_by(skill_id: @skill.id, dog_id: id).update(level: params["dogskill"]["#{id}"])
        end

        redirect to "/skills/#{@skill.id}"
    end

# Delete (C.R.U.Destroy)
    delete "/skill/:id" do
        @skill = Skill.find_by(id: params[:id])
        @skill.destroy_all
        redirect to "/library"
    end
end
    