Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "lists#index"

  # get '/lists/:id', to: 'lists#show', as: :list
  # get '/movies', to: 'movies#index'
  resources :movies, only: [:index]
  resources :lists, only: [:index, :new, :show, :create] do
    resources :bookmarks, only: [:new, :create]
  end

  resources :bookmarks, only: [:show, :destroy]

end
