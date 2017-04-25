mike = User.create({name: "Mike", password: "pass"})
john = User.create({name: "John", password: "word"})

denver = City.create(name: "Denver")
newyork = City.create(name: "New York")

largeporch = Amenity.create(name: "Large Porch")
jacuzzi = Amenity.create(name: "Jacuzzi")

house1 = mike.listings.build({name: "Large House", price: 10000000, sqm: 400})
house1.city = denver
house1.amenities << jacuzzi
house1.save


house2 = john.listings.build({name: "Fancy House", price: 13200000, sqm: 300})
house2.city = newyork
house2.amenities << jacuzzi
house2.amenities << largeporch
house2.save
