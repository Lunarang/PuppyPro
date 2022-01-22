class Dog < ActiveRecord::Base
    belongs_to :user
    has_many :trackers
    has_many :skills, through: :trackers

    validates :name, presence: true
    
    def age
        date_of_birth = self.dob
        ((Date.current.to_time - date_of_birth.to_time) / 1.year.seconds).floor
    end

end
