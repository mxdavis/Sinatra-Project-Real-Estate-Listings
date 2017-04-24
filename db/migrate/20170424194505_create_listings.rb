class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :name
      t.string :price
      t.string :sqm
      t.integer :user_id
      t.integer :city_id
    end
  end
end
