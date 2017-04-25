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
    end
    flash[:message] = "You need to login to add a listing"
    redirect to '/login'
  end

  post '/listings' do
    binding.pry
    listing = Listing.create(params[:listing])
    if params[:title][:name] != ""
      listing.titles << Title.create(params[:title])
    end
    if params[:landmark][:name] != ""
      listing.landmarks << Landmark.create(params[:landmark])
    end

    redirect to "/listings/#{listing.slug}"
  end

end
