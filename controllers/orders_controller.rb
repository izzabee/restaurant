class OrdersController < ApplicationController


	# Shows receipt
	get '/:party_id/receipt' do |party_id|

		@party = Party.find(party_id)
		@orders = @party.foods	

		@tax = (0.0875).to_f

		erb :'orders/receipt'
	end

	# Edit a party's order
	get '/:party_id/edit' do |party_id|

		@party = Party.find(party_id)
		@orders = @party.orders
		@foods = Food.all

		erb :'orders/edit'
	end

	# Makes new order for a party
	post '/:party_id/edit' do |party_id|

		order = Order.create( params[:order] )

		redirect to("/#{party_id}/edit")
	end

	# Comps item for a party
	patch '/:order_id/order' do |order_id|

		order = Order.find(order_id)
		order.update( params[:order] )

		redirect to("/#{order.party_id}/edit")
	end

	# Adds tip for a party
	patch '/:id/receipt' do |id|

		parties = Party.find(id)
		parties.update( params[:party] )

		redirect to("/#{id}/receipt")
	end

	# Deletes a food order for a party
	delete '/:order_id/order' do |order_id|

		order = Order.find(order_id)		
		order.destroy

		redirect to "/#{order.party_id}/edit"
	end

end