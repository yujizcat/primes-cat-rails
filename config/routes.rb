Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resource :users do
    resource :players, only: [:new, :create]
  end

  get "/users/newbie", to: "users#newbie"
  get "/users/ranking", to: "users#ranking"
  post "users/levelup"
  post "users/leveldown"
  get "games/select", to: "games#select"
  get "games/add_cards", to: "games#add_cards"
  get "games/backtomain", to: "games#backtomain"
  resource :users
  resource :users do
    resource :players, only: [:show]
  end
  #get "/players/:id", to: "players#show"
  post "/players/create", to: "players#create"
  post "/games/create", to: "games#create"
  get "/games/practice", to: "games#practice"
  get "/games/challenge", to: "games#challenge"

  root to: "users#index"
end
