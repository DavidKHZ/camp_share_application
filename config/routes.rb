Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/category/:category', to: 'pages#category', as: 'category'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :offers, only: %i[index show new create edit update] do
    resources :bookings, only: %i[create]
  end

  get '/dashboard', to: 'pages#dashboard'
  get '/bookings/:id&:new_status', to: 'bookings#update_status', as: 'update_booking_status'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
