class TopicsController < ApplicationController

    get '/topics' do
        @session = session
        erb :'/topics/index'
    end

end