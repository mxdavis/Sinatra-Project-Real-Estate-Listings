class Listing < ActiveRecord::Base

  has_many :listing_amenities
  has_many :amenities, through: :listing_amenities
  belongs_to :user
  belongs_to :city

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
end
