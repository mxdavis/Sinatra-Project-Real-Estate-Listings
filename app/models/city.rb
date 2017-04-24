class City < ActiveRecord::Base

  has_many :listings

  # include Slugifiable::InstanceMethods
  # extend Slugifiable::ClassMethods
end
