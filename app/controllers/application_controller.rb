require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, '35e4288babe81ab1b40bb612b125ab415bb9c973f85b95b2d69ae251133d6a48f92eb2c7d90caec2813820508ae5599855bf2ab04473cd4d45da31d3644f3686'
        use Rack::Flash
    end

    get '/' do
        redirect '/topics'
    end

    helpers do
        def logged_in?(session)
            !!session[:user_id]
        end

        def current_user(session)
            User.find_by(id: session[:user_id])
        end

        def redirect_if_logged_out(session, flash, message, route)
            if !logged_in?(session)
                flash[:message] = "You must be logged in to #{message}."
                session[:failed_due_to_not_logged_in] = route
                redirect '/login'
            end
        end
    end


end