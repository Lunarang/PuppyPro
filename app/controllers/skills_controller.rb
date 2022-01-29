class SkillsController < ApplicationController

# Index
    get "/skills" do
        # removed Skill Index due to the way each Skills associate with Users
        # Skills belong to Users
        # all Users create new instances of the same 10 basic skills upon creation
        redirect '/library'
    end

# New (Create.R.U.D) - GET
    get "/skills/new" do
        verify_user_login

        erb :"/skills/new"
    end

# New (Create.R.U.D) - POST
    post "/skills/new" do
        verify_user_login
        @skill = Skill.new(params["skill"])

        if @skill.valid?
            @skill.user_id = @user.id
            @skill.save

            params["dogskill"].each do |dog_id|
                id = dog_id.to_i
                DogSkill.find_by(skill_id: @skill.id, dog_id: id).update(level: params["dogskill"]["#{id}"])
            end

            redirect '/library'
        else
            flash[:error] = @skill.errors.full_messages
            redirect '/skills/new'
        end
    end
    
# Show (C.Read.U.D)
    get "/skills/:id" do
        @skill = Skill.find(params[:id])
        @creator = User.find_by_id(@skill.user_id)

        erb :"skills/show"
    end

# Edit (C.R.Update.D) - GET
    get "skills/:id/edit" do
        verify_user_login
        @skill = Skill.find(params[:id])

        if @skill.user_id == @user.id
            erb :"/skills/edit"
        else
            flash[:notice] = "You can only edit skills that belong to your own library!"
            redirect to "/skills/#{@skills.id}"
        end
    end

# Edit (C.R.Update.D) - PATCH
    patch "/skills/:id" do
        verify_user_login
        @skill = Skill.find(params[:id])

        if @skill.user_id == @user.id
            @skill.update(params["skill"])
        
            params["dogskill"].each do |dog_id|
                id = dog_id.to_i
                dogskill = DogSkill.find_by(skill_id: @skill.id, dog_id: id)
                dogskill.update(level: params["dogskill"]["#{id}"])
            end
        else
            flash[:notice] = "You can only edit skills that belong to your own library!"
        end

        redirect to "/skills/#{@skills.id}"
    end

# Delete (C.R.U.Destroy)
    delete "/skill/:id" do
        verify_user_login
        @skill = Skill.find_by(id: params[:id])

        if @skill.user_id == @user.id
            @skill.destroy_all
            redirect to "/library"
        else
            flash[:notice] = "You can only delete your own skills!"
            redirect to "/skills/#{@skill.id}"
        end
    end

end
    