Rails.application.routes.draw do
  resources :items
  resources :users
  resources :accounts

  post "auth/login", to: "auth#login"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "test" => "tests#test"

  get "auth/connect-token" => "auth#get_connect_token"
  # Defines the root path route ("/")
  # root "posts#index"
end
