<!-- Make file directory and config ru, rakefile, gems, layout page make with all the <!DOCTYPE html> <html> (maybe navbar if time) -->

<!-- Make:
  User
    username
    password
    has many Listings -->

  <!-- Listings
    Name
    Price
    SQM
    has_many amenities through listing_amenities
    belongs_to user
    belongs_to city -->

  <!-- City
    name
    has_many Listings -->

  <!-- Amenity
    name  
    has many listings through listing_amenities -->


<!-- Application Controller, tables and models for User, Listing, City, Amenity -->

<!-- Index
  Page with all listings -->

<!-- Sign Up:
  Secure password
  Username and password required <-- if not redirect to same page with error
  Once signed in redirect to page with all users listings with option to edit and delete each -->


<!-- Sign In
  Make sure password and username match or else provide error
  Once signed in redirect to page with all users listings with option to edit and delete each -->

<!-- Helpers
  Logged in
  slugifiable -->

<!-- Edit listings -->
  <!-- Form
  Must be logged in
  Make sure only user can edit his own listing -->
  <!-- make sure one of each type is filled out -->

<!-- /listing/slug -->

<!-- City
  Shows cities (with link)
  Click link to see listings in that city /city/slug
  edit? -->


<!-- User -->
  <!-- Login -->
  <!-- Logout -->

<!-- Listing -->
  <!-- Create new
  edit -->
  <!-- delete if belongs to user -->
