class CarWashesController < ApplicationController
  require "http"
  before_action :authenticate_user

  # show all car_washes based on user coordinates
  def index
    lat = current_user.latitude
    lon = current_user.longitude
    response = HTTP.get("https://maps.googleapis.com/maps/api/place/textsearch/json", params: {
      query: "car wash",
      location: "#{lat},#{lon}",
      radius: 10000,
      region: "us",
      type: "car_wash",
      key: Rails.application.credentials.google_maps_api_key
    })
    data = response.parse(:json)
    data = data["results"]
    excluded_keywords = ["Mr. Magic", "SoftTouch", "Softtouch", "Soft Touch", "Soft-Touch", "Self-Service", "Self Service", "Self-Serve", "Self Serve"]
    @car_washes = data
    @car_washes = @car_washes.reject { |wash| excluded_keywords.any? { |keyword| wash["name"].include?(keyword) } }

    render json: @car_washes
  end

  # show a specific car wash
  def show
    id = params[:id]
    response = HTTP.get("https://maps.googleapis.com/maps/api/place/details/json?&place_id=#{id}&fields=name,formatted_address,opening_hours,formatted_phone_number,rating,website,photos,reviews&key=#{Rails.application.credentials.google_maps_api_key}")
    @car_wash = response.parse(:json)
    render json: @car_wash
  end
  
end
