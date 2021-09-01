ENV['SINATRA_ENV'] ||= "default"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/forum.sqlite"
)

require_all 'app'
