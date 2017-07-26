require 'bundler'
Bundler.require

# Setup a DB connection here
require 'pry'
# require_relative "../db/seed"


DB = {:conn => SQLite3::Database.new("db/daily.db")}
