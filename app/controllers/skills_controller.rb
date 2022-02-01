class SkillsController < ApplicationController

# Index
    get "/skills" do
        # removed Skill Index due to the way each Skills associate with Users
        # Skills belong to Users
        # all Users create new instances of the same 10 basic skills upon creation
        redirect '/library'
    end

# New (Create.R.U.D) - GET
    get "/skill/new" do
        verify_user_login

        erb :"/skills/new"
    end

# New (Create.R.U.D) - POST
    post "/skills" do
        verify_user_login
        @skill = Skill.new(params["skill"])

        if @skill.valid?
            @skill.user_id = @user.id

            if !params["dog_ids"].empty?
                params["dog_ids"].each do | id |
                    dog = Dog.find_by_id(id)
                    DogSkill.create(dog_id: dog.id, skill_id: @skill.id, level: params["dog_lvls"]["#{id}"])
                end
            end

            @skill.save
            flash[:notice] = "Skill successfully added to your library!"
            redirect '/library'
        else
            flash.now[:error] = @skill.errors.full_messages
            erb :"/skills/new"
        end
    end
    
# Show (C.Read.U.D)
    get "/skills/:id" do
        current_user
        @skill = Skill.find_by_id(params[:id])
        @creator = User.find_by_id(@skill.user_id)

        erb :"skills/show"
    end

# Edit (C.R.Update.D) - GET
    get "/skills/:id/edit" do
        verify_user_login
        @skill = Skill.find_by_id(params[:id])

        if @skill.user_id == @user.id
            erb :"/skills/edit"
        else
            flash[:notice] = "You can only edit skills that belong to your own library!"
            redirect to "/skills/#{params[:id]}"
        end
    end

# Edit (C.R.Update.D) - PATCH
    patch "/skills/:id" do
        verify_user_login
        @skill = Skill.find_by_id(params[:id])

        if @skill.user_id == @user.id
            @skill.update(params["skill"])
        
            if !params["skill"]["dog_ids"].empty?
                params["skill"]["dog_ids"].each do | id |
                    dog = Dog.find_by_id(id)
                    dogskill = DogSkill.find_by(dog_id: dog.id, skill_id: @skill.id)
                    dogskill.update(level: params["dog_lvls"]["#{id}"])
                end
            end

            flash[:notice] = "Skill successfully updated!"
        else
            flash[:notice] = "You can only edit skills that belong to your own library!"
        end

        redirect to "/skills/#{params[:id]}"
    end

# Delete (C.R.U.Destroy)
    delete "/skills/:id" do
        verify_user_login
        @skill = Skill.find_by_id(params[:id])

        if @skill.user_id == @user.id
            @skill.destroy
            flash[:notice] = "Skill successfully deleted..."
            redirect to "/library"
        else
            flash[:notice] = "You can only delete your own skills!"
            redirect to "/skills/#{params[:id]}"
        end
    end

end
    