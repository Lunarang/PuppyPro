ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

configure :development do
  set :database, "sqlite3:db/#{ENV['SINATRA_ENV']}.db"
end

require 'rack-flash'
require 'date'

require './app/controllers/application_controller'

require_all 'app'
