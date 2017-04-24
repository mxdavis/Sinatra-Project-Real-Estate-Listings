class CreateListingAmenities < ActiveRecord::Migration[5.0]
  def change
    create_table :listing_amenities do |t|
      t.string :listing_id
      t.string :amenity_id
      t.timestamps null: false
    end
  end
end
