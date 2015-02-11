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
	# set :app_password, "1234"

	###################
	##### ROUTES ######
	###################

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

	get '/css/:name.css' do |name|
		content_type :css
		scss "../public/sass/#{name}".to_sym, :layout => false
	end

end
