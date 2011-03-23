require 'active_record'
require 'sinatra/base'
require 'sinatra/session'
require 'yaml'

require_relative 'models/user'
require_relative 'models/post'

class Francis < Sinatra::Base

  configure do
    register Sinatra::Session
    set :session_secret, 'k3j4h5b5bv67v77g'
  end

  configure :development do
    dbconfig = YAML.load( File.read('config/database.yml') )
    ActiveRecord::Base.establish_connection dbconfig['development']
  end

  configure :production do
    dbconfig = YAML.load( File.read('config/database.yml') )
    ActiveRecord::Base.establish_connection dbconfig['production']
  end

  helpers do
  end

  before "*admin*" do
    unless session? && session[:user]
      session_start!
      session[:return_to] = request.fullpath
      redirect '/login'
    end
  end

  # ===== Root Routes =====
  get '/' do
    "Hello Francis"
  end

  # ===== Admin Routes =====
  
  get '/admin' do
    "admin"
  end

  get '/login' do
    haml :login
  end

  post '/login' do
    record = User.find_by_username(params[:user]['username'])
    if record && record.password_hash == Digest::SHA1.hexdigest(params[:user]['password'])
      session[:user] = true
      return_to = session[:return_to] || '/temp'
      session[:return_to] = nil
      redirect return_to
    else
      # set flash
      redirect '/login'
    end
  end
  
  get '/logout' do
    session_end!
    redirect '/'
  end

  # ===== Post Routes =====


  not_found do
    "404 - fill this in"
  end

end
