class User < ActiveRecord::Base
  has_many :listings
  has_secure_password
  validates_presence_of :name, :password_digest

  include Slugifiable::InstanceMethods
  # extend Slugifiable::ClassMethods

  def self.find_by_slug(slug)
    self.all.detect do |s|
      s.name.downcase == slug.gsub("-", " ")
    end
  end

end
