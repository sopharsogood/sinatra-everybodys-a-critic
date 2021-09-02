class Message < ActiveRecord::Base
    belongs_to :user
    belongs_to :topic

    def display_content
        self.content.gsub("\r\n","<br>")
    end
end