class User < ActiveRecord::Base
    has_secure_password
    validates :username, presence: true, uniqueness: true

    has_many :messages
    has_many :topics, through: :messages

    SLUG_CODEBOOK = {
        "$" => "S",
        "(" => "",
        ")" => "",
        "." => "",
        "&" => "and",
        " " => "-",
        '"' => "",
        "'" => "",
        "+" => "plus"
    }

    def slug
        self.username.gsub(/\W/,SLUG_CODEBOOK).downcase
    end
    
    def self.find_by_slug(slug)
        self.all.detect do |user|
            user.slug == slug
        end
    end

    
end