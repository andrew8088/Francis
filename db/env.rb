require 'active_record'
require 'yaml'

db = YAML.load File.read "config/database.yml"

ActiveRecord::Base.establish_connection db["development"]

require_relative '../models/user'
require_relative '../models/post'
