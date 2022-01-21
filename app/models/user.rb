class User < ActiveRecord::Base
    has_many :dogs
    has_many :skills
    has_secure_password
    
    validates :name, presence: true
    validates :password_digest, :email, presence: true
    validates :email, uniqueness: true

    after_create do
        Skill.base_library(self)
    end

end
