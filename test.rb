require "sinatra"
require "sinatra/activerecord"
require "./models"
require "sinatra/flash"

enable :sessions
set :database, "sqlite3:main.db"


get "/" do
	erb :index
end

get "/debug" do
	@users = User.all
	@user = current_user
	@profile = current_profile
	erb :debug	
end

post "/sign-in" do
	@user=User.where(username: params[:username]).first
	if @user && @user.password==params[:password]
		session[:user_id]=@user.id
		flash[:notice]="You're signed in!"
		redirect "/update_profile"
	else 
		flash[:error]="Incorrect Information!"
		redirect "/"
	end
end

get "/profile" do
	@user = current_user
	@profile = current_profile
	erb :profile
end

post "/create_profile" do
	@user = current_user
	@profile = current_profile
	
	Profile.create(
		user_id: current_user.id,
		city: params[:city],
		field: params[:field],
		bio: params[:bio],
		)
 		 		
 	flash[:notice]="You have updated profile!"
	redirect "/profile"
end

get "/update_profile" do
	@user = current_user
	@profile = current_profile
	erb :profile
end

post "/update_profile" do
	@profile = current_profile	
	@profile.update(
		city: params[:city],
		field: params[:field],
		bio: params[:bio],
		)
		
	flash[:notice]="You have updated profile!"
	redirect "/profile"
end

post "/update_password" do
	@user = current_user
	# @current_user.password=User.find(session[:user_id]).password
	if @user.password == params[:c_password]
			
 		@user.update(
 			password: params[:n_password]
 		)
 		
 		flash[:notice]="You have changed password!"
		redirect "/profile"
	else
		flash[:error]="Incorrect!"
		redirect "/profile"
	end
end

get "/account" do
	@user = current_user
	@profile = current_profile
	# @profile = Profile.find_by(user_id: session[:user_id])
	erb :account

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

def current_profile
	if session[:user_id]
		@current_profile=Profile.find_by(user_id: session[:user_id])
	end
end