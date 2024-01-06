Rails.application.routes.draw do
  resources :transactions
  resources :items
  resources :users
  resources :accounts

  get "setup/transactions", to: "transactions#first_setup_transactions"
  get "categories/transactions", to: "transactions#get_amount_per_category"

  post "auth/login", to: "auth#login"
  # post "auth/login-with-token", to: "application#current_user"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "test" => "tests#test"
  # get "test" => "test#transactions_parameters"

  get "auth/connect-token" => "auth#get_connect_token"
  # Defines the root path route ("/")
  # root "posts#index"
end

