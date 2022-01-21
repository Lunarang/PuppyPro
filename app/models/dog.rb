class Dog < ActiveRecord::Base
    belongs_to :user
    has_many :trackers
    has_many :skills, through: :trackers

    validates :name, presence: true
    
end
