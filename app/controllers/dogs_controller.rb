class DogsController < ApplicationController

# Index
    get "/dogs" do
        redirect "/home"
    end

# New (Create.R.U.D) - GET
    get "/dogs/new" do
        login_required
        current_user

        erb :"/dogs/new"
    end

# New (Create.R.U.D) - POST
    post "/dogs/new" do
        login_required
        current_user
        @dog = Dog.new(params["dog"])

        if @dog.valid?
            @dog.user_id = @user.id
            @dog.save

            params["dogskill"]["skill_ids"].each do |skill_id|
                id = skill_id.to_i
                DogSkill.create(skill_id: id, dog_id: @dog.id)
            end

            params["dogskill"]["skill_lvls"].each do |skill_id, level|
                if params["dogskill"]["skill_ids"].include?(skill_id)
                    id = skill_id.to_i
                    level = "novice" if level == "none"
                    DogSkill.find_by(skill_id: id, dog_id: @dog.id).update(level: level)
                end
            end

            if !params["skill"].empty?
                new_skill = Skill.create(name: params["skill"]["name"], description: params["skill"]["description"], method: params["skill"]["method"])
                DogSkill.create(skill_id: new_skill.id, dog_id: @dog.id, level: params["skill"]["level"])
            end

            redirect '/home'
        else
            flash[:error] = @dog.errors.full_messages
            redirect '/dogs/new'
        end
    end
  
# Show (C.Read.U.D)
    get "/dogs/:id" do
        current_user
        @dog = Dog.find(params[:id])

        erb :"dogs/show"
    end

# Edit (C.R.Update.D) - GET
    get "/dogs/:id/edit" do
        login_required
        @dog = Dog.find(params[:id])

        if @dog.user_id == current_user.id
            erb :"/dogs/edit"
        else
            flash[:notice] = "You can only edit your own pups!"
            redirect to "/dogs/#{@dog.id}"
        end
    end

# Edit (C.R.Update.D) - PATCH
    patch "/dogs/:id/edit" do
        login_required

        @dog = Dog.find(params[:id])
        @dog.update(name: params["dog"]["name"], sex: params["dog"]["sex"], dob: params["dog"]["dob"])
        
        skill_list = []
        params["dogskill"]["skill_ids"].each do |skill_id|
            id = skill_id.to_i
            skill_list << id
        end

        skill_list.each do |id|
        
            skill = Skill.find_by(id: id)
            dogskill = DogSkill.find_by(skill_id: id, dog_id: @dog.id)

            if !skill_list.include?(id) && @dog.skills.include?(skill)
                dogskill.destroy_all
            elsif skill_list.include?(id) && @dog.skills.include?(skill)
                dogskill.update(level: params["dogskill"]["skill_id"])
            elsif !@dog.skills.include?(skill)
                DogSkill.create(skill_id: id, dog_id: @dog.id, level: params["dogskill"]["skill_id"])
            end

        end

        if !params["skill"].empty?
            new_skill = Skill.create(name: params["skill"]["name"], description: params["skill"]["description"], method: params["skill"]["method"])
            DogSkill.create(skill_id: new_skill.id, dog_id: @dog.id, level: params["skill"]["level"])
        end

        @dog.save

        redirect to "/dogs/#{@dog.id}"
    end

# Delete (C.R.U.Destroy)
    delete "/dogs/:id" do
        @dog = Dog.find_by(id: params[:id])
        @dog.destroy_all
        redirect to "/home"
    end

end
