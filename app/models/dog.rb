class Dog < ActiveRecord::Base
    belongs_to :user
    has_many :dog_skills
    has_many :skills, through: :dog_skills

    validates :name, presence: true
    
    def age
        date_of_birth = self.dob
        ((Date.current.to_time - date_of_birth.to_time) / 1.year.seconds).floor
    end

    def mastered_skills
        mastered_skills = []
        self.skills.each do |skill|
            mastered_skills << skill if skill.level(self.id) == "Expert"
        end
        mastered_skills
    end

end
