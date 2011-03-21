
namespace :db do

  desc "Migrate the Database"
  task :migrate do
    ActiveRecord::Migrator.migrate "db/migrate"
  end

  desc "Create Migration; don't forget the NAME variable!"  # taken from https://github.com/bmizerany/sinatra-activerecord/blob/master/lib/sinatra/activerecord/rake.rb
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
