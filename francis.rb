require 'active_record'
require 'sinatra/base'
require 'yaml'

require_relative 'models/user'
require_relative 'models/post'

class Francis < Sinatra::Base

  configure do
    enable :sessions
  end

  configure :development do
    dbconfig = YAML.load( File.read('config/database.yml') )
    ActiveRecord::Base.establish_connection dbconfig['development']
  end

  configure :production do
    #require 'yaml'
    dbconfig = YAML.load( File.read('config/database.yml') )
    ActiveRecord::Base.establish_connection dbconfig['production']
  end

  helpers do
    
  end

  before "*admin*" do
    
  end

  # ===== Root Routes =====
  get '/' do
    "Hello Francis"
  end

  # ===== Admin Routes =====


  # ===== Post Routes =====


  not_found do
    "404 - fill this in"
  end

end
