class UserController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/user/listings'
    end
    erb :'/users/create_user'
  end

  post '/signup' do
    if !!(User.find_by(name: params[:user][:name]))
      # flash -> you are already a user
      redirect to '/login'
    end
    if !(params[:user].has_value?(""))

      user = User.create(name: params[:user][:name].downcase, password: params[:user][:password])
      session["user_id"] = user.id
      redirect to '/users/user_listings'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/users/user_listings'
    end
    erb :'/users/login'
  end

  post '/login' do
  @user = User.find_by(name: params[:user][:name].downcase)
  	if @user && @user.authenticate(params[:password])
      session["user_id"] = @user.id
      redirect to '/users/user_listings'
    else
      # flash something was not right
      redirect to "/login"
    end
	end

  get '/logout' do
    if logged_in?
      session.clear
    else
      redirect to '/'
    end
    redirect to '/login'
  end
end
