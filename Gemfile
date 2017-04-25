source 'http://rubygems.org'
ruby '2.3.0'

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'sqlite3', :group => :development
gem 'thin'
gem 'shotgun', :group => :development
gem 'pry'
gem 'bcrypt'
gem "tux"
gem 'rack-flash3'
gem 'sinatra-twitter-bootstrap', :require => 'sinatra/twitter-bootstrap'

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
