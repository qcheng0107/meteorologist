require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    @street_address.gsub(" ", ",+")
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address
    open(url).read
    raw_data = open(url).read
    parse_data = JSON.parse(raw_data)
    parse_data["results"]
    @latitude = parse_data["results"][0]["geometry"]["location"]["lat"]
    @longitude = parse_data["results"][0]["geometry"]["location"]["lng"]
    
    url = "https://api.darksky.net/forecast/f0a880d4d19458be63ea744f9728b54c/#{@latitude},#{@longitude}"
    weather_data = open(url).read
    parse_data2 = JSON.parse(weather_data)
    parse_data2["results"]


    @current_temperature = parse_data2["currently"]["temperature"]

    @current_summary = parse_data2["currently"]["summary"]

    @summary_of_next_sixty_minutes = parse_data2["minutely"]["summary"]

    @summary_of_next_several_hours = parse_data2["hourly"]["summary"]

    @summary_of_next_several_days = parse_data2["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
