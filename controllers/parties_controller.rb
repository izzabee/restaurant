class PartiesController < ApplicationController

	# Shows all parties
	get '/' do 

		@parties = Party.where("table_id != 0").all

		erb :'parties/index'
	end
	
	# Shows checked out parties
	get '/past' do 

		@parties = Party.where("table_id = 0").all

		erb :'parties/past'
	end

	# Add new party
	get '/new' do 

		erb :'parties/new'
	end

	# Creates new party
	post '/' do 

		party = Party.create( params[:party] )

		if party.valid?
			redirect to('/')
			params[:party][:employee_id] = session[:id]
		else
			@party = party
			@error_messages = party.errors.messages
			erb :'parties/new'
		end
	end

	# Shows individual parties 
	get '/:id' do |id|

		@party = Party.find(id)
		@orders = @party.foods

		erb :'parties/show'
	end

	# Update party
	get '/:id/edit' do |id|

		@party = Party.find(id)

		erb :'parties/edit'
	end

	# Updates party in db
	patch '/:id' do |id|

		party = Party.find(id)
		party.update( params[:party] )

		if party.valid?
			redirect to("/#{id}")
		else
			@party = party
			@error_messages = party.errors.messages
			erb :'parties/edit'
		end

	end

	# Sets party table_id to 0 for checkout
	patch '/checkout/:id' do |id|

		party = Party.find(id)
		party.update(params[:party])

		redirect to("/")
	end

	# Deletes food from party's order
	delete '/:id' do |id|

		party = Party.find(id)
		party.destroy

		redirect to("/")
	end

	# Deletes party from db
	delete '/:id' do |id|

		redirect to("/#{id}")
	end

end