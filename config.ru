#\ -p 3000

require_relative 'environment'
require_relative 'app.rb'

require 'securerandom'

map('/foods') { run FoodsController }
map('/parties') { run PartiesController }
map('/orders') { run OrdersController }
map('/employees') { run EmployeesController }
run Restaurant