class Amenity < ActiveRecord::Base

  has_many :listing_amenities
  has_many :listings, through: :listing_amenities

  # include Slugifiable::InstanceMethods
  # extend Slugifiable::ClassMethods
end
