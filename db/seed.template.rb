require 'active_record'
require 'yaml'
require 'digest/sha1'

dbconfig = YAML.load File.read "config/database.yml"
ActiveRecord::Base.establish_connection dbconfig["development"]

require_relative '../models/user'

# fill in these attributes
attrs = { first_name: "", last_name: "", username: "", email_address: "", password_hash: Digest::SHA1.hexdigest("") }

unless User.find_by_first_name attrs[:first_name]
  user User.new attrs

  if user.save
    puts "user #{user.username} saved."
  else
    puts "error: user not created."
  end
end
