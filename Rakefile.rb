require 'active_record'
require 'yaml'

namespace :db do

  task :environment do
    dbconfig = YAML.load( File.load('config/database.yml'))
    ActiveRecord::Base.establish_connection dbconfig["development"]
    ActiveRecord::Base.logger = Logger.new(File.open("logs/dev.log", "a"))
  end

  desc "Migrate the Database"
  task :migrate => :environment do
    ActiveRecord::Migrator.migrate "db/migrate"
  end

  # taken from https://github.com/bmizerany/sinatra-activerecord/blob/master/lib/sinatra/activerecord/rake.rb
  desc "Create Migration; don't forget the NAME variable!"  
  task :create_migration do
    name = ENV['NAME']
    abort("no NAME specified. use `rake db:create_migration NAME=create_users`") if !name
    migrations_dir = File.join("db", "migrate")
    version = ENV["VERSION"] || Time.now.utc.strftime("%Y%m%d%H%M%S") 
    filename = "#{version}_#{name}.rb"
    migration_name = name.gsub(/_(.)/) { $1.upcase }.gsub(/^(.)/) { $1.upcase }
    FileUtils.mkdir_p(migrations_dir)
    open(File.join(migrations_dir, filename), 'w') do |f|
      f << (<<-EOS).gsub("      ", "")
      class #{migration_name} < ActiveRecord::Migration
        def self.up
        end

        def self.down
        end
      end
      EOS
    end
  end
end
