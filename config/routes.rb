Rails.application.routes.draw do

  root to: "home#index"
  get "/about", to: "home#about", as: :about
  
  get "auth/twitter/callback", to: 'sessions#create'
  delete "logout", to: 'sessions#destroy'

  resource :user

  post "tweet", to: 'users#tweet'

  get "/superheroes", to: 'superheros#index'
  resources :superheros, only: [:show]
end
