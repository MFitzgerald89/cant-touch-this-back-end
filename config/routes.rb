Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # creates session
  post "/sessions" => "sessions#create"

  #creates new user
  post "/users" => "users#create"
end
