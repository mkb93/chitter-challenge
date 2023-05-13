require_relative 'lib/database_connection'
require_relative 'lib/peep_repository'
require_relative 'lib/users_repository'
require_relative 'lib/users'
require_relative 'lib/peep'
require 'bcrypt'
require 'sinatra/base'
require 'sinatra/reloader'
require 'mail'
require 'date'

DatabaseConnection.connect

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  enable :sessions
  configure :development do
    register Sinatra::Reloader
  end

  Mail.defaults do
    delivery_method :smtp, {
      address: 'smtp.elasticemail.com',
      port: 587,
      user_name: 'nfk18@msn.com',
      password: 'C49AB22E0D650362E9B3073C12B4527146AC',
      authentication: :plain,
      enable_starttls_auto: true
    }
  end
get '/' do
  repo = PeepRepository.new
  @users = UsersRepository.new
  
  @all = repo.all.reverse

  return erb(:index)
end
get '/sign_up' do
  return erb(:sign_up)
end
post '/new_user' do
  @fullname = params[:fullname]
  @username = params[:username]
  @email = params[:email]
  @password = params[:password]
  repo = UsersRepository.new
  
  matched_email = repo.find_email(@email)
  matched_username = repo.find_username(@username)

  
  if !matched_email && !matched_username 
    new_user = User.new(@username, @fullname, @email, @password)
    repo.create(new_user)
    repo = repo.all 
    session[:user] = new_user
    return erb(:getting_started)
  else
    return erb(:already_exists)
  end
end
get '/peep/new' do
  if session[:user] == nil
    return redirect('/log_in')
  else
    @user = session[:user]
  return erb(:new_peep)
  end
end
post '/' do
  @content = params[:content] 
  @username = session[:user].username
  
  
  repo = PeepRepository.new
  @users = UsersRepository.new
  @user_id = @users.find_username(@username).id
  peep = Peep.new(@content, @user_id)
  repo.create(peep)
  
  
  @all = repo.all.reverse
  return erb(:index)
end
get '/log_in' do
  if session[:user] != nil
    return redirect(:user)
  else
  return erb(:log_in)
  end
end
post '/user' do
  password = params[:password]
  @users = UsersRepository.new
  @user = UsersRepository.new.find_username(params[:username])
  @peeps = PeepRepository.new.all.reverse 
  if @users.login(@user.email, @user.password)
    session[:user] = @user
    return erb(:user)
  else
    return redirect(:log_in)
  end
end
get '/user' do
  if session[:user] == nil
    return redirect('/log_in')
  else
    @user = session[:user]
    @peeps = PeepRepository.new.all.reverse 
    return erb(:user)
  end
end
get '/log_out' do
  session[:user] = nil
  return redirect('/')
end
get '/send_email' do
  # Create a new email message
  @mail_to = session[:user].email
  mail_from = 'Chitter'
  email_from = 'nfk18@hotmail.co.uk'
  if @mail_to.nil? || @mail_to.empty?
    return 'Recipient email address is required.'
  end
  mail = Mail.new do |message|
    
    message.from    "#{mail_from} <#{email_from}>"
    message.to      @mail_to
    message.subject 'Welcome to chitter'
    message.body    "your account is registered to #{session[:user].full_name} has officially been created on #{DateTime.now}. Your username is #{session[:user].username}, please make sure your password is secure as we don't have a recovery system yet. "
  end

  # Send the email
  begin
    mail.deliver!
    'Email sent successfully.'
  rescue => e
    "Failed to send email. Error: #{e.message}"
  end
  return erb(:email)
end
end
# We need to give the database name to the method `connect`.

