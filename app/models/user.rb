class User < ActiveRecord::Base
    has_secure_password
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true

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
        "+" => "plus",
        "-" => "-"
    }

    def slug
        self.username.gsub(/\W/,SLUG_CODEBOOK).downcase
    end
    
    def self.find_by_slug(slug)
        self.all.detect do |user|
            user.slug == slug
        end
    end

    def link
        "<a href='/users/#{self.slug}'>#{self.username}</a>"
    end

    def topics_uniq
        self.topics.reverse.uniq.reverse
    end

    def topics_created # because user.topics returns the topics the user has posted in, not created
        Topic.all.select {|topic| topic.op == self}
    end
    
end