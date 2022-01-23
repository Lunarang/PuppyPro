class DogSkill < ActiveRecord::Base
    belongs_to :dog
    belongs_to :skill

    @levels = ["Novice", "Beginner", "Competent", "Proficient", "Expert"]

end
