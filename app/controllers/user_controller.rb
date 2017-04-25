class UserController < ApplicationController

  get '/signup' do
    if logged_in?
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

      @user = User.create(name: params[:user][:name].downcase, password: params[:user][:password])
      session["user_id"] = @user.id
      redirect to "/user/#{@user.slug}"
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if logged_in?
      @user = User.find(session[:user_id])
      redirect to "/user/#{@user.slug}"
    end
    erb :'/users/login'
  end

  post '/login' do
  @user = User.find_by(name: params[:user][:name].downcase)
  	if @user && @user.authenticate(params[:user][:password])
      session["user_id"] = @user.id
      redirect to "/user/#{@user.slug}"
    else
      flash[:message] = "Username and/or password are not correct. Please try again or signup for an account"
      redirect to "/login"
    end
	end

  get '/users/user_panel' do
    if @user = current_user

      redirect to "/user/#{@user.slug}"
    else
      flash[:message] = "Please login to see your user panel"

      redirect to "/login"
    end
  end

  get '/user/:slug' do
    @user = User.find_by_slug(params[:slug])
    if @user == current_user
      @listings = @user.listings.all
      erb :'/users/listings'
    else
      flash[:message] = "Please login to see your user panel"
      redirect to "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end

  helpers do

      def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      end

      def logged_in?
      	!!self.current_user
      end

  end
end
