require 'active_record'
require 'sinatra/base'
require 'yaml'

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


end
