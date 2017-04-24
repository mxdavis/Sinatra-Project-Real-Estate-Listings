class ListingController < Sinatra::Base

  get '/listings' do
    @listings = Listings.all
    erb :'listings/index'
  end
end
