#\ -p 3000

# Make sure we load all the gems
require 'bundler'
Bundler.require :default

# Connect to the restaurant database
set :database, {
  adapter: "postgresql", database: "restaurant",
  host: "localhost", port: 5432
}

require './app'
run Restaurant