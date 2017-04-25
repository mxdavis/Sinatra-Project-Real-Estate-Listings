class ListingController < ApplicationController

  get '/listings' do
    if Helpers.logged_in?(session)
      @user = Helpers.current_user(session)
    end
    @listings = Listing.all
    erb :'listings/index'
  end

  get '/listings/new' do
    if Helpers.logged_in?(session)
      erb :'listings/new'
    else
      flash[:message] = "You need to login to add a listing"
      redirect to '/login'
    end
  end

  post '/listings' do
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

    @listing.save

    redirect to "/listings/#{@listing.slug}"
  end

  get '/listings/:slug' do
    @listing = Listing.find_by_slug(params[:slug])
    erb :'/listings/show'
  end

end
