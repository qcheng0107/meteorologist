require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]

    @street_address.gsub(" ", ",+")
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address
    open(url).read
    raw_data = open(url).read
    parse_data = JSON.parse(raw_data)
    parse_data["results"]
    @latitude = parse_data["results"][0]["geometry"]["location"]["lat"]
    @longitude = parse_data["results"][0]["geometry"]["location"]["lng"]
    
    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    render("geocoding/street_to_coords.html.erb")
  end
end
