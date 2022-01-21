class Skill < ActiveRecord::Base
    belongs_to :user
    has_many :trackers
    has_many :dogs, through: :trackers

    validates :name, presence: true
    validates :description, presence: true

    def self.base_library(user)
        Skill.create(name: "Sit", description: "Puppy put your butt on the ground!", user_id: "#{user.id}")
        Skill.create(name: "Kiss", description: "Give me kisses! Kisses!", user_id: "#{user.id}")
        Skill.create(name: "Speak", description: "Let me hear you BARK!", user_id: "#{user.id}")
        Skill.create(name: "Fetch", description: "I'll throw this, you bring it back!", user_id: "#{user.id}")
        Skill.create(name: "Roll Over", description: "Show me your tummy!", user_id: "#{user.id}")
        Skill.create(name: "Stay", description: "Don't move a muscle!", user_id: "#{user.id}")
        Skill.create(name: "Shake", description: "Give me your paw, nice to meet you!", user_id: "#{user.id}")
        Skill.create(name: "Down", description: "Lay down!", user_id: "#{user.id}")
        Skill.create(name: "Play Dead", description: "Pow! Pow! Keel over puppy!", user_id: "#{user.id}")
        Skill.create(name: "Spin", description: "Let's make circles until we're happy and dizzy!", user_id: "#{user.id}")
    end

end
