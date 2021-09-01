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

    class Helper
        def logged_in?(session)
            !!session[:user_id]
        end

        def current_user(session)
            User.find_by(id: session[:user_id])
        end
    end


end