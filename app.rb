Dir["models/*.rb"].each do |file|
  require_relative file
end

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


### FOODS ###


# Shows entire menu
get '/foods' do 

	@foods = Food.all

erb :'foods/index'
end

# Add new food to menu
get '/foods/new' do 

erb :'foods/new'
end

# Creates new food
post '/foods' do 

	foods = Food.create( params[:foods] )

redirect to('/foods')
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

	food = Food.update( params[:foods] )

redirect to('foods/id')
end

# Deletes food item from db
delete '/foods/:id' do |id|

	food = Food.find(id)
	food.destroy

redirect to('foods/id')
end


### PARTIES ###


# Shows all parties
get '/parties' do 

	@parties = Party.all

erb :'parties/index'
end

# Add new party
get '/parties/new' do 

erb :'parties/new'
end

# Creates new party
post '/parties' do 

	parties = Party.create( params[:parties] )

redirect to('/parties')
end

# Shows individual parties 
get '/parties/:id' do |id|

	@party = Party.find(id)
	@orders = parties.foods

erb :'parties/show'
end

# Update a party
get '/parties/:id/edit' do |id|

erb :'parties/edit'
end

# Updates party in db
patch '/parties/:id' do |id|

redirect to('parties/id')
end

# Deletes party from db
delete '/parties/:id' do |id|

redirect to('parties/id')
end
