require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url = "https://api.darksky.net/forecast/f0a880d4d19458be63ea744f9728b54c/"+@lat+","+@lng
    raw_data = open(url).read
    parse_data = JSON.parse(raw_data)
    parse_data["results"]

    @current_temperature = parse_data["currently"]["temperature"]

    @current_summary = parse_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parse_data["minutely"]["summary"]

    @summary_of_next_several_hours = parse_data["hourly"]["summary"]

    @summary_of_next_several_days = parse_data["daily"]["summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end
