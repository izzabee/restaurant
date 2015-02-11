class EmployeesController < ApplicationController


	# Log in for employees sessions
	get '/' do

		@employees = Employee.all

		erb :'employees/login'
	end

	# Shows a specific employee and their parties
	get '/:id' do |id|

    @employee = Employee.find(id)
    @party = @employee.parties

    erb :'employees/show'
  end

	# Starts session for a particular employee
	post '/' do

		session[:id] = params[:employee_id]
		employee = Employee.find(params[:employee_id])

		redirect to "/#{employee.id}"
	end

end