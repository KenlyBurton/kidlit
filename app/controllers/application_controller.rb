class ApplicationController < Sinatra::Base
	set :views, "app/views"
	set :public, "public"

	get '/' do 
		"hey"
	end
end