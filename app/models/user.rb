class User < ActiveRecord::Base
    has_secure_password
    validates :username, presence: true, uniqueness: true

    has_many :messages
    has_many :topics, through: :messages
end