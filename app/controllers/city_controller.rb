class UserController < ApplicationController
  get '/cities/:slug' do
    @city = City.find_by_slug(params[:slug])
    erb :'/cities/show'
  end

end
