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
	erb :profile
end