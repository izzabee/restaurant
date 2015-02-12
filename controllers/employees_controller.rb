
class EmployeesController < ApplicationController

	# Homepage
	get '/' do 
		@employee ||= Employee.find_by(authorization_token: session[:authorization_token])
		# Pry.start(binding)
		erb :index
	end

	# Sign up
  get '/signup' do

    erb :'employees/signup'
  end

  post '/signup' do
  	# Pry.start(binding)
    @employee = Employee.new( name: params[:employee][:name] )

    if params[:employee][:password] == params[:employee][:password_confirmation]
      @employee.set_password = params[:employee][:password]

      if @employee.save
        login!(@employee)

        redirect to('/')
      else
        erb :'employees/signup'
      end
    else
      # @employee.errors.add(:password, "and confirmation need to match.")

      erb :'employees/signup'
    end
  end

  # Need a way to sign in

  get '/login' do
    @employee = Employee.new

    erb :'employees/login'
  end

  post '/login' do

	 @employee = Employee.find_by_name(params[:employee][:name])

    if @employee
      login!(@employee)

      redirect to('/')
    else
      @employee = User.new(name: params[:employee][:name])

      # @employee.errors.add(:password, "and email are not a valid combination.")
      erb :login
    end

  	redirect to('/')
  end

  # Need a way to sign out

  delete '/logout' do
    logout!
    redirect to('/login')
  end

	# Shows a specific employee and their parties
	get '/:id' do |id|

    @employee = Employee.find(id)
    @party = @employee.parties

    erb :'employees/show'
  end

  # Need a way to check we're signed in

  private
  def create_token
    # this will provide us with a randomized string, and will be
    # used by current_user, and login!
    return SecureRandom.urlsafe_base64
  end

  def current_user
    # if a employee has authorization_token equal to the one stored in
    # session, they're our de facto current employee
    Employee.find_by(authorization_token: session[:authorization_token])
  end

  def login!(employee)
    # this will be called when a employee has authenticated.  it will need
    # to create an authorization_token, and set it for both the session
    # and the employee

    employee.authorization_token = session[:authorization_token] = create_token

    employee.save
  end

  def logout!
    employee = current_user

    employee.authorization_token = session[:authorization_token] = nil

    employee.save
  end

end