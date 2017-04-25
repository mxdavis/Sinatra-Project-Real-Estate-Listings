class UserController < ApplicationController

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect to '/user/listings'
    end
    erb :'/users/create_user'
  end

  post '/signup' do
    if !!(User.find_by(name: params[:user][:name]))
      flash[:message] = "You already have an account, please login"
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
    if Helpers.logged_in?(session)
      redirect to '/users/user_listings'
    end
    erb :'/users/login'
  end

  post '/login' do
  @user = User.find_by(name: params[:user][:name].downcase)
  	if @user && @user.authenticate(params[:user][:password])
      session["user_id"] = @user.id
      redirect to '/users/user_listings'
    else
      flash[:message] = "Username and/or password are not correct. Please try again or signup for an account"
      redirect to "/login"
    end
	end

  get '/logout' do
    if Helpers.logged_in?(session)
      session.clear
    else
      redirect to '/'
    end
    redirect to '/login'
  end
end
