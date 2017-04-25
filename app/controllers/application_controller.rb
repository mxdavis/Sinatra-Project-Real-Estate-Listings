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
    if logged_in?
      redirect to '/listings'
    end
    @listing = Listing.all
    erb :index
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
