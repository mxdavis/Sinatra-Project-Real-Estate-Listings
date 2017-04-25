class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "password_security"
  end

  get '/' do
    if Helpers.logged_in?(session)
      redirect to '/listings'
    end
    @listing = Listing.all
    erb :index
  end

end
