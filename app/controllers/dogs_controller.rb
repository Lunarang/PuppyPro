class DogsController < ApplicationController

# Index
    get "/dogs" do
        redirect "/home"
    end

# New (Create)
    get "/dogs/new" do
        login_required

        erb :"/dogs/new"
    end

    post "/dogs/new" do
        login_required
        current_user
        @dog = Dog.new(params["dog"])

        if @dog.valid?
            @dog.save
            params["dogskill"].each do |skill_id|
                id = skill_id.to_i
                DogSkill.find_by(skill_id: id, dog_id: @dog.id).update(level: params["dogskill"]["#{skill_id}"])
            end

            if !params["skill"].empty?
                new_skill = Skill.create(name: params["skill"]["name"], description: params["skill"]["description"], method: params["skill"]["method"])
                DogSkill.create(skill_id: new_skill.id, dog_id: @dog.id, level: params["skill"]["level"])
            end
            redirect '/home'

        else
            flash[:error] = @dog.errors.full_messages

        end
    end
  
# Show (Read, Delete)
    get "/dogs/:id" do
        current_user
        @dog = Dog.find(params[:id])

        erb :"dogs/show"
    end

# Edit (Update)
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

    patch "/dogs/:id" do
        login_required

        @dog = Dog.find(params[:id])
        @dog.update(name: params["dog"]["name"], sex: params["dog"]["sex"], dob: params["dog"]["dob"])
        
        skill_list = []
        params["dog"]["skill_ids"].each do |skill_id|
            id = skill_id.to_i
            skill_list << id
        end

        skill_list.each do |id|
        
            skill = Skill.find_by(id: id)
            dogskill = DogSkill.find_by(skill_id: id, dog_id: @dog.id)

            if !skill_list.include?(skill.id) && @dog.skills.include?(skill)
                dogskill.destroy_all
            elsif skill_list.include?(skill.id) && @dog.skills.include?(skill)
                dogskill.update(level: params["dogskill"]["#{skill_id}"])
            elsif !@dog.skills.include?(skill)
                DogSkill.create(skill_id: skill.id, dog_id: @dog.id, level: params["dogskill"]["#{skill_id}"])
            end

        end

        if !params["skill"].empty?
            new_skill = Skill.create(name: params["skill"]["name"], description: params["skill"]["description"], method: params["skill"]["method"])
            DogSkill.create(skill_id: new_skill.id, dog_id: @dog.id, level: params["skill"]["level"])
        end

        @dog.save

        redirect to "/dogs/#{@dog.id}"
    end

# Delete (Destroy)
    delete "/dogs/:id" do
        @dog = Dog.find_by(id: params[:id])
        @dog.destroy_all
        redirect to "/home"
    end

end
