Dir["models/*.rb"].each do |file|
  require_relative file
end

# class Restaraunt < Sinatra::Base
# 	register Sinatra::ActiveRecordExtension
# 	enable :method_override 
# 	enable :sessions
# 	set :app_password, "1234"

	###################
	##### ROUTES ######
	###################

	# Console
	get '/console' do 
		Pry.start(binding)
		""
	end

	# Homepage
	get '/' do 

	erb :index
	end


	#############
	### FOODS ###
	#############


	# Shows entire menu
	get '/foods' do 

		@foods = Food.all

	erb :'foods/index'
	end

	# Shows all vegetarian items
	get '/foods/veg' do 

		@foods = Food.all

	erb :'foods/veg'
	end
	# Shows all gluten-free items
	get '/foods/gluten' do 

		@foods = Food.all

	erb :'foods/gluten'
	end

	# Shows all dairy-free items
	get '/foods/dairy' do 

		@foods = Food.all

	erb :'foods/dairy'
	end

	# Shows all nut-free items
	get '/foods/nuts' do 

		@foods = Food.all

	erb :'foods/nuts'
	end


	# Add new food to menu
	get '/foods/new' do 

		@foods = Food.all

	erb :'foods/new'
	end

	# Creates new food
	post '/foods' do 

		foods = Food.create( params[:foods] )

		if foods.valid?
			redirect to('/foods')
		else
			@foods = food
			@error_message = food.errors.messages
			
			erb :'foods/new'
		end

	end

	# Shows specific food descriptors
	get '/foods/:id' do |id|

		@food = Food.find(id)

	erb :'foods/show'
	end

	# Update a menu item
	get '/foods/:id/edit' do |id|

		@food = Food.find(id)

	erb :'foods/edit'
	end

	# Updates food item in db
	patch '/foods/:id' do |id|

		food = Food.find(id)
		food.update( params[:foods] )

	redirect to("foods/#{id}")
	end

	# Deletes food item from db
	delete '/foods/:id' do |id|

		food = Food.find(id)
		food.destroy

	redirect to("foods/#{id}")
	end

	###############
	### PARTIES ###
	###############


	# Shows all parties
	get '/parties' do 

		@parties = Party.all
		# Pry.start(binding)

	erb :'parties/index'
	end

	# Add new party
	get '/parties/new' do 

	erb :'parties/new'
	end

	# Creates new party
	post '/parties' do 

		parties = Party.create( params[:parties] )
		params[:party][:employee_id] = session[:employee_id]

    Party.new( params[:party] )

	redirect to('/parties')
	end

	# Shows individual parties 
	get '/parties/:id' do |id|

		@party = Party.find(id)
		@orders = @party.foods

	erb :'parties/show'
	end

	# Update party
	get '/parties/:id/edit' do |id|

		@party = Party.find(id)

	erb :'parties/edit'
	end

	# Updates party in db
	patch '/parties/:id' do |id|

		party = Party.find(id)
		party.update(params[:parties])

	redirect to("parties/#{id}")
	end

	# Adds tip for a party
	patch '/orders/:id/receipt' do |id|

		parties = Party.find(id)
		parties.update(params[:parties])

	redirect to("orders/#{id}/receipt")
	end

	# Sets party table_id to 0 for checkout
	patch '/parties/checkout/:id' do |id|

		party = Party.find(id)
		party.update(params[:parties])

	redirect to("/parties")
	end

	# Deletes food from party's order
	delete '/parties/:id' do |id|

		party = Party.find(id)
		party.destroy

	redirect to("/parties")
	end

	# Deletes party from db
	delete '/parties/:id' do |id|

	redirect to("parties/#{id}")
	end


	##############
	### ORDERS ###
	##############

	# Shows receipt
	get '/orders/:id/receipt' do |id|

		@party = Party.find(id)
		@orders = @party.foods	

		@tax = (0.0875).to_f

		# Pry.start(binding)
	erb :'orders/receipt'
	end

	# Edit a party
	get '/orders/:id/edit' do |id|

		@party = Party.find(id)
		@orders = @party.foods
		@foods = Food.all

	erb :'orders/edit'
	end

	# Makes new order for a party
	post '/orders/:id/edit' do |id|

		order = Order.create( params[:order] )

	redirect to("orders/#{id}/edit")
	end

	# Comps item for a party
	patch '/orders/:id/receipt' do |id|

		order = Order.find(id)
		order.update(params[:order])

	redirect to("orders/#{id}/edit")
	end

	# Deletes a food order for a party
	delete '/orders/:id/order' do |id|
		
		order = Order.where("party_id = #{id} AND food_id = #{params[:food][:id]}")
		order.first.destroy

	redirect to "/orders/#{id}/edit"
	end


	#################
	### EMPLOYEES ###
	#################


	# Log in for employees sessions
	get '/employees' do

		@employees = Employee.all

	erb :'employees/login'
	end

	# Shows a specific employee and their parties
	get '/employees/:id' do |id|

    @employee = Employee.find(id)
    @party = @employee.parties

    erb :'employees/show'
  end

	# Starts session for a particular employee
	post '/employees' do

		session[:id] = params[:employee_id]
		employee = Employee.find(params[:employee_id])

	redirect to "/employees/#{employee.id}"
	end

# end
