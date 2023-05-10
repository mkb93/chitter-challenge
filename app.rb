require_relative 'lib/database_connection'
require_relative 'lib/peep_repository'
require_relative 'lib/users_repository'
require 'sinatra/base'
require 'sinatra/reloader'

DatabaseConnection.connect

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end
get '/' do
  repo = PeepRepository.new
  @users = UsersRepository.new
  
  @all = repo.all

  return erb(:index)
end
get '/sign_up' do
  return erb(:sign_up)
end
post '/new_user' do
  @username = params[:username]
  return erb(:getting_started)
end
get '/peep/new' do
  return erb(:new_peep)
end
post '/' do
  @content = params[:content] 
  repo = PeepRepository.new
  @users = UsersRepository.new
  
  @all = repo.all
  return erb(:index)
end
end
# We need to give the database name to the method `connect`.

