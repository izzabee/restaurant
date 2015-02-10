Dir["models/*.rb"].each do |file|
  require_relative file
end

configure do 
	set :scss, {:style => :compressed, :debug_info => false}
end

class Restaurant < Sinatra::Base
	register Sinatra::ActiveRecordExtension
	enable :method_override 
	enable :sessions
	set :app_password, "1234"

	###################
	##### ROUTES ######
	###################

	get '/css/:name.css' do |name|
		content_type :css
		scss "../public/sass/#{name}".to_sym, :layout => false
	end

	before '*' do 
	  unless (request.path == '/employees' || session[:id])
	    redirect to('/employees')
	  end
	end

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

		food = Food.create( params[:food] )

		if food.valid?
			redirect to('/foods')
		else
			@food = food
			@error_messages = food.errors.messages
			
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

		redirect to("/foods")
	end

	###############
	### PARTIES ###
	###############


	# Shows all parties
	get '/parties' do 

		@parties = Party.where("table_id != 0").all

		erb :'parties/index'
	end
	
	# Shows checked out parties
	get '/parties/past' do 

		@parties = Party.where("table_id = 0").all

		erb :'parties/past'
	end

	# Add new party
	get '/parties/new' do 

		erb :'parties/new'
	end

	# Creates new party
	post '/parties' do 

		party = Party.create( params[:party] )

		if party.valid?
			redirect to('/parties')
			params[:party][:employee_id] = session[:id]
		else
			@party = party
			@error_messages = party.errors.messages
			erb :'parties/new'
		end
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
		party.update( params[:party] )

		if party.valid?
			redirect to("parties/#{id}")
		else
			@party = party
			@error_messages = party.errors.messages
			erb :'parties/edit'
		end

	end

	# Adds tip for a party
	patch '/orders/:id/receipt' do |id|

		parties = Party.find(id)
		parties.update( params[:party] )

		redirect to("orders/#{id}/receipt")
	end

	# Sets party table_id to 0 for checkout
	patch '/parties/checkout/:id' do |id|

		party = Party.find(id)
		party.update(params[:party])

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
	get '/orders/:party_id/receipt' do |party_id|

		@party = Party.find(party_id)
		@orders = @party.foods	

		@tax = (0.0875).to_f

		erb :'orders/receipt'
	end

	# Edit a party's order
	get '/orders/:party_id/edit' do |party_id|

		@party = Party.find(party_id)
		@orders = @party.orders
		@foods = Food.all

		erb :'orders/edit'
	end

	# Makes new order for a party
	post '/orders/:party_id/edit' do |party_id|

		order = Order.create( params[:order] )

		redirect to("orders/#{party_id}/edit")
	end

	# Comps item for a party
	patch '/orders/:order_id/order' do |order_id|

		order = Order.find(order_id)
		order.update( params[:order] )

		redirect to("/orders/#{order.party_id}/edit")
	end

	# Deletes a food order for a party
	delete '/orders/:order_id/order' do |order_id|

		order = Order.find(order_id)		
		order.destroy

		redirect to "/orders/#{order.party_id}/edit"
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

end
