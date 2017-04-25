class User < ActiveRecord::Base
  has_many :listings
  has_secure_password
  validates_presence_of :name, :password_digest

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

end
