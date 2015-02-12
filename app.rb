configure do 
	set :scss, {:style => :compressed, :debug_info => false}
end

class Restaurant < Sinatra::Base
	register Sinatra::ActiveRecordExtension
	enable :method_override 
	enable :sessions
	# set :app_password, "1234"

	# before '*' do 
	#   unless (request.path == '/employees/signup' || session[:id])
	#     redirect to('/employees/signup')
	#   end
	# end

	# Console
	get '/console' do 
		Pry.start(binding)
		""
	end

	get '/css/:name.css' do |name|
		content_type :css
		scss "../public/sass/#{name}".to_sym, :layout => false
	end


end
