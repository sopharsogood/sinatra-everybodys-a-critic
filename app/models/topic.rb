class Topic < ActiveRecord::Base
    has_many :messages
    has_many :users, through: :messages

    def link
        "<a href='/users/#{self.id}'>#{self.title}</a>"
    end

    def op
        self.messages.first.user
    end
end