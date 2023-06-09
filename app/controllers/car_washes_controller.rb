class CarWashesController < ApplicationController

  before_action :authenticate_user

  # show all coffee shops based on user coordinates
  def index
    lat = current_user.latitude
    lon = current_user.longitude
    response = HTTP.get("https://maps.googleapis.com/maps/api/place/textsearch/json?query=carwash&location=#{lat},#{lon}&radius=10000&region=us&type=car_wash&key=#{Rails.application.credentials.google_maps_api_key}")
    data = response.parse(:json)
    data = data["results"]
    bad_wash = ["Brushless, Brush-less, Brush Less, Brush-Less, SoftTouch, Softtouch, Soft Touch, Soft-Touch, Touch, Self-Service, Self Service, Self-Serve, Self Serve"]
    data = data.delete_if { |x| bad_wash.include? x["name"] }
    @car_washes = data
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
