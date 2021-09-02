class MessagesController < ApplicationController

    get '/topics/:id/reply' do
        if !Helper.logged_in?(session)
            flash[:message] = "You must be logged in to post messages."
            session[:failed_due_to_not_logged_in] = '/topics/' + params[:id].to_s + '/reply'
            redirect '/login'
        end
        @topic = Topic.find_by(id: params[:id])
        @session = session
        erb :'/messages/new'
    end

    get '/messages/:id' do
        @message = Message.find_by(id: params[:id])
        @session = session
        erb :'/messages/show'
    end

    get '/messages/:id/edit' do
        if !Helper.logged_in?(session)
            flash[:message] = "You must be logged in to edit messages."
            session[:failed_due_to_not_logged_in] = '/messages/' + params[:id].to_s + '/edit'
            redirect '/login'
        end
        @message = Message.find_by(id: params[:id])
        if Helper.current_user(session) != @message.user
            flash[:message] = "Only the original poster of a message can edit it."
            redirect '/topics/' + params[:id].to_s
        end
        if @message.topic.messages.first == @message
            redirect '/topics/' + @message.topic.id.to_s + '/edit'
        else
            @session = session
            erb :'/messages/edit'
        end
    end

    get '/messages/new' do
        flash[:message] = "New messages must be created as new topics or as replies to existing topics."
        redirect '/topics'
    end

    post '/topics/:id/reply' do
        if !Helper.logged_in?(session)
            flash[:message] = "You must be logged in to post messages."
            session[:failed_due_to_not_logged_in] = '/topics/' + params[:id].to_s + '/reply'
            redirect '/login'
        end
        if params[:content] == ""
            flash[:message] = "Messages can't be blank."
            redirect '/topics/' + params[:id].to_s + '/reply'
        end
        topic = Topic.find_by(id: params[:id])
        message = Message.create(user: Helper.current_user(session), content: params[:content], topic: topic)
        redirect '/topics/' + params[:id].to_s
    end

    patch '/messages/:id/edit' do
        if !Helper.logged_in?(session)
            flash[:message] = "You must be logged in to edit messages."
            session[:failed_due_to_not_logged_in] = '/messages/' + params[:id].to_s + '/edit'
            redirect '/login'
        end
        message = Message.find_by(id: params[:id])
        if Helper.current_user(session) != message.user
            flash[:message] = "Only the original poster of a message can edit it."
            redirect '/topics/' + params[:id].to_s
        end
        message.update(content: params[:content])
        flash[:message] = "Message edited!"
        redirect '/topics/' + message.topic.id
    end

end