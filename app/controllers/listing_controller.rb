class ListingController < ApplicationController

  get '/listings' do
    if logged_in?
      @user = current_user
    end
    @listings = Listing.all
    erb :'listings/index'
  end

  get '/listings/new' do
    if logged_in?
      erb :'listings/new'
    else
      flash[:message] = "You need to login to add a listing"
      redirect to '/login'
    end
  end

  post '/listings' do
    if !check_form_filled_out?(params)
      flash[:message] = "Please make sure all fields are filled out and your listing belongs to a city, and has at least one amenity"
      redirect to '/listings/new'
    end

    if !check_if_listing_name_unique?(params)
      flash[:message] = "#{@listing.name} has already been taken. Please use a new name"
      redirect to '/listings/new'
    end
    @listing = Listing.find_or_create_by(params[:listing])
    if params[:city][:name] != ""
      @listing.city = City.find_or_create_by(params[:city])
    else
      @listing.city = City.find(params[:city_ids])
    end
    if params[:amenity][:name] != ""
      @listing.amenities << Amenity.find_or_create_by(params[:amenity])
    end

    params[:amenity_ids].each do |id|
      @listing.amenities << Amenity.find(id)
    end

    @listing.user = current_user

    @listing.save

    redirect to "/listings/#{@listing.slug}"
  end

  get '/listings/:slug' do
    @listing = Listing.find_by_slug(params[:slug])
    erb :'/listings/show'
  end

  post '/listings/:slug' do

    @listing = Listing.find_by_slug(params[:slug])

    if !check_form_filled_out?(params)
      flash[:message] = "Please make sure all fields are filled out and your listing belongs to a city, and has at least one amenity"
      redirect to "/listings/#{@listing.slug}/edit"
    end

    if params[:city][:name] != ""
      @listing.city = City.find_or_create_by(params[:city])
    else
      @listing.city = City.find(params[:city_ids])
    end

    @listing.amenities.clear

    if params[:amenity][:name] != ""
      @listing.amenities << Amenity.find_or_create_by(params[:amenity])
    end

    params[:amenity_ids].each do |id|
      @listing.amenities << Amenity.find(id)
    end

    @listing.save

    flash[:message] = "#{@listing.name} has been successfully updated"

    redirect to "/listings/#{@listing.slug}"
  end

  get '/listings/:slug/edit' do
    if @user = current_user
      @listing = Listing.find_by_slug(params[:slug])
      erb :'/listings/edit'
    else
      flash[:message] = "Please login to edit your listing"
      redirect to "/login"
    end
  end

  get '/listings/:slug/delete' do
    if @user = current_user
      @listing = Listing.find_by_slug(params[:slug])
      erb :'/listings/delete'
    else
      flash[:message] = "Please login to delete your listing"
      redirect to "/login"
    end
  end

  delete '/listings/:slug/delete' do
    @user = current_user
    @listing = Listing.find_by_slug(params[:slug])
    @listing.delete
    flash[:message] = "Your listing has been deleted"
    redirect to "/user/#{@user.slug}"
  end

  helpers do
    def check_form_filled_out?(params)
      !params[:listing].has_value?("") && !!(params.has_key?("city_ids") || params[:city][:name] != "") && !!(params.has_key?("amenity_ids") || params[:amenity][:name] != "")
    end

    def check_if_listing_name_unique?(params)
      # Otherwise the slug will not work
      !(@listing = Listing.all.detect{|listing| listing.name == params[:listing][:name].downcase})
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!self.current_user
    end

  end

end
