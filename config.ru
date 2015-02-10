#\ -p 3000

# Make sure we load all the gems
require 'bundler'
Bundler.require :default

# Connect to the restaurant database
set :database, {
  adapter: "postgresql", database: "restaurant"
}

require './app'
run Restaurant