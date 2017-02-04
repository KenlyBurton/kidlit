require 'bundler'
Bundler.require
# The block of code below configures out database in development - we'll use a sqlite3 database that's stored in a folder called "db"
configure :development do
 set :database, "sqlite3:db/database.db"
end
configure :production do
ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"])
end