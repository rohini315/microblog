require "sinatra"
require "sinatra/activerecord"
require "./models"
require "sinatra/flash"

set :database, "sqlite3:main.db"
