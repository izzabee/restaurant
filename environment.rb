require 'rubygems'
require 'bundler'
Bundler.require :default

ActiveRecord::Base.establish_connection({
    adapter: 'postgresql',
    dbname: 'restaurant',
    host: 'localhost', port: 5432
  })

['models', 'helpers', 'controllers'].each do |component|
  Dir["#{component}/*.rb"].sort.each do |file|
    require File.expand_path(file)
  end
end