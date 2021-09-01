class UsersController < ApplicationController

    get '/signup' do
        if Helper.logged_in?(session)
            flash[:message] = "You're already logged in!"
            redirect '/topics'
        end
        @session = session
        erb :'/users/signup'
    end

    get '/login' do
        if Helper.logged_in?(session)
            flash[:message] = "You're already logged in!"
            redirect '/topics'
        end
        @session = session
        erb :'/users/login'
    end

    get '/logout' do
        if !Helper.logged_in?(session)
            flash[:message] = "You're already logged out!"
            redirect '/login'
        end
        flash[:message] = "Logout successful! Goodbye, #{Helper.current_user(session).username}!"
        session[:user_id] = nil
        redirect '/login'
    end

    post '/login' do
        user = User.find_by(username: params[:user][:username])
        if user && user.authenticate(params[:user][:password])
            session[:user_id] = user.id
            session[:message] = "Login successful! Welcome back, #{Helper.current_user(session).username}!"
            if session[:failed_due_to_not_logged_in]
                return_destination = session[:failed_due_to_not_logged_in].to_s
                session[:failed_due_to_not_logged_in] = nil
                redirect return_destination
            else
                redirect '/topics'
            end
        else
            flash[:message] = "Incorrect username or password. Login failed. Sorry!"
            redirect '/login'
        end
    end

    post '/signup' do
        user = User.new(params[:user])
        if user.save
            session[:user_id] = user.id
            session[:message] = "Signup successful! Welcome, #{Helper.current_user(session).username}!"
            redirect '/topics'
        else
            flash[:message] = "An error occurred. Signup failed."
            redirect '/signup'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @session = session
        erb :'/users/show'
    end
end