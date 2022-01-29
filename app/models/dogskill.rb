class DogSkill < ActiveRecord::Base
    belongs_to :dog
    belongs_to :skill

    @levels = ["novice", "beginner", "competent", "proficient", "expert"]

end
