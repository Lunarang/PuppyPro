class DogsController < ApplicationController

# Index
    get "/dogs" do
        redirect "/home"
    end

# New (Create.R.U.D) - GET
    get "/dog/new" do
        verify_user_login

        erb :"/dogs/new"
    end

# New (Create.R.U.D) - POST
    post "/dogs" do
        verify_user_login
        @dog = Dog.new(params["dog"])

        if @dog.valid?
            @dog.user_id = @user.id

            if !params["dog"]["skill_ids"].empty?
                params["dog"]["skill_ids"].each do | id |
                    skill = Skill.find_by_id(id)
                    DogSkill.create(skill_id: skill.id, dog_id: @dog.id, level: params["skill_lvls"]["#{id}"])
                end
            end

            if !params["skill"].empty?
                new_skill = Skill.create(params["skill"])
                new_skill.user_id = @user.id
                new_skill.save
                DogSkill.create(skill_id: new_skill.id, dog_id: @dog.id, level: params["new_skill_lvl"])
            end

            @dog.save
            flash[:notice] = "Puppy successfully created! :)"
            redirect '/home'
        else
            flash.now[:error] = @dog.errors.full_messages
            erb :"/dogs/new"
        end
    end
  
# Show (C.Read.U.D)
    get "/dogs/:id" do
        @dog = Dog.find_by_id(params[:id])
        @owner = User.find_by_id(@dog.user_id)

        erb :"dogs/show"
    end

# Edit (C.R.Update.D) - GET
    get "/dogs/:id/edit" do
        verify_user_login
        @dog = Dog.find_by_id(params[:id])

        if @dog.user_id == @user.id
            erb :"/dogs/edit"
        else
            flash[:notice] = "You can only edit your own pups!"
            redirect to "/dogs/#{params[:id]}"
        end
    end

# Edit (C.R.Update.D) - PATCH
    patch "/dogs/:id" do
        verify_user_login
        @dog = Dog.find_by_id(params[:id])

        if @dog.user_id == @user.id
            @dog.update(params["dog"])
            
            if !params["dog"]["skill_ids"].empty?
                params["dog"]["skill_ids"].each do | id |
                    skill = Skill.find_by_id(id)
                    dogskill = DogSkill.find_by(skill_id: skill.id, dog_id: @dog.id)
                    dogskill.update(level: params["skill_lvls"]["#{id}"])
                end
            end

            if !params["skill"].empty?
                new_skill = Skill.create(params["skill"])
                new_skill.user_id = @user.id
                new_skill.save
                DogSkill.create(skill_id: new_skill.id, dog_id: @dog.id, level: params["new_skill_lvl"])
            end

            flash[:notice] = "Puppy successfully updated! :)"
            redirect '/home'
        else
            flash[:notice] = "You can only edit your own pups!"
        end

        redirect to "/dogs/#{params[:id]}"
    end

# Delete (C.R.U.Destroy)
    delete "/dogs/:id" do
        verify_user_login
        @dog = Dog.find_by_id(params[:id])
        
        if @dog.user_id == @user.id
            @dog.destroy
            flash[:notice] = "Puppy... deleted... :("
            redirect to "/home"
        else
            flash[:notice] = "You can only delete your own pups!"
            redirect to "/dogs/#{params[:id]}"
        end
    end

end
