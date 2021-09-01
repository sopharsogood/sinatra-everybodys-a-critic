class TopicsController < ApplicationController

    get '/topics' do
        @session = session
        @topics = Topic.all.sort_by {|topic| topic.messages.last.created_at}
        erb :'/topics/index'
    end

end