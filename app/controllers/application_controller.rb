require "./config/environment"
require_relative "../models/book.rb"
require_relative "../models/review.rb"
require_relative "../models/user.rb"
require_relative "../models/age.rb"
require 'sinatra'
class ApplicationController < Sinatra::Base
	configure do
		set :public_folder, 'public'
		set :views, 'app/views'
		  enable :sessions
   set :session_secret, "kidlit"
	end
	
	helpers do 
		def logged_in?
			session["user_id"]
		end
	end

	get '/book/:id' do
		@the_book = Book.find_by_id(params["id"])
		erb :book
	end

	get '/' do 
		erb :index
	end

	get '/books' do
		@baby=Age.find_by_age_group("baby").books
		@toddler=Age.find_by_age_group("toddler").books
		@kindergarten=Age.find_by_age_group("kindergarten").books
		@elementary_school=Age.find_by_age_group("elementary school").books
		@middle_school=Age.find_by_age_group("middle school").books
		@high_school=Age.find_by_age_group("high school").books
		erb :books
	end 

	get '/books/new' do
		if session["user_id"] 
			@age_groups=Age.all
			erb :new_books
		else 
			redirect "/login"
		end
	end

	post '/books/new' do 
		@book = Book.new
		@book.title=params["title"]
		@book.author=params["author"]
		@book.genre=params["genre"]
		@book.age_id=params["book_age"]
		@book.save
		redirect "/book/#{@book.id}"
	end

	get '/reviews/new' do
		if session["user_id"]
			@library = Book.all
			erb :new_review
		else 
			redirect '/login'
		end
	end

	post '/reviews/new' do
		puts params
		@review = Review.new
		@review.content=params["content"]
		@review.book_id=params["book"]
		@review.user_id=session["user_id"]
		@review.save
		redirect "/book/#{@review.book_id}"
	end



	get '/signup' do
		erb :signup
	end

	post '/signup' do
		puts params
		@user = User.new
		@user.email=params["email"]
		@user.password=params["password"]
		@user.save
		session["user_id"] = @user.id
		redirect "/"
	end

	get '/login' do
		erb :login
	end

	post '/login' do
		@user=User.find_by_email(params["email"])
		if @user && @user.password == params["password"]
			session["user_id"] = @user.id
			puts session["user_id"]
			redirect "/"
		else 
			redirect "/login"
		end
	end

	get '/logout' do
		session.destroy
		redirect '/login'
	end 

	post '/search' do 
		@books=Book.where(title: params["book"])
		erb :search
	end



end