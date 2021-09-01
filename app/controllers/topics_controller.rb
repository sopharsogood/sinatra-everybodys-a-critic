class TopicsController < ApplicationController

    get '/topics' do
        @session = session
        @topics = Topic.all
        erb :'/topics/index'
    end

end