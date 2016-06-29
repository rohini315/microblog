require "sinatra"
require "sinatra/activerecord"
require "./models"
require "sinatra/flash"

enable :sessions
set :database, "sqlite3:main.db"


get "/" do
	erb :index	
end

post "/sign-in" do
	@user=User.where(username: params[:username]).first
	if @user && @user.password==params[:password]
		session[:user_id]=@user.id
		flash[:notice]="You're signed in!"
		redirect "/profile"
	else 
		flash[:error]="Incorrect Information!"
		redirect "/"
	end
end

get "/profile" do
	@user=current_user
	erb :profile
end

post "/sign-up" do
	User.create(
	username: params[:username],
	password: params[:password],
	phone: params[:phone],
	name: params[:name]
	)
	flash[:notice]="You have signed up"

	redirect "/profile"
end

def current_user
	if session[:user_id]
		@current_user=User.find(session[:user_id])
	end
end