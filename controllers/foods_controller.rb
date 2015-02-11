class FoodsController < ApplicationController


	# Shows entire menu
	get '/' do 

		@foods = Food.all

		erb :'foods/index'
	end

	# Shows all vegetarian items
	get '/veg' do 

		@foods = Food.all

		erb :'foods/veg'
	end
	# Shows all gluten-free items
	get '/gluten' do 

		@foods = Food.all

		erb :'foods/gluten'
	end

	# Shows all dairy-free items
	get '/dairy' do 

		@foods = Food.all

		erb :'foods/dairy'
	end

	# Shows all nut-free items
	get '/nuts' do 

		@foods = Food.all

		erb :'foods/nuts'
	end

	# Add new food to menu
	get '/new' do 

		@foods = Food.all

		erb :'foods/new'
	end

	# Creates new food
	post '/' do 

		food = Food.create( params[:food] )

		if food.valid?
			redirect to('/')
		else
			@food = food
			@error_messages = food.errors.messages
			
			erb :'foods/new'
		end
	end

	# Shows specific food descriptors
	get '/:id' do |id|

		@food = Food.find(id)

		erb :'foods/show'
	end

	# Update a menu item
	get '/:id/edit' do |id|

		@food = Food.find(id)

		erb :'foods/edit'
	end

	# Updates food item in db
	patch '/:id' do |id|

		food = Food.find(id)
		food.update( params[:foods] )

		redirect to("/#{id}")
	end

	# Deletes food item from db
	delete '/:id' do |id|

		food = Food.find(id)
		food.destroy

		redirect to("/")
	end

end