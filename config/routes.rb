Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resource :users do
    resource :players, only: [:new, :create]
  end

  get "/users/newbie", to: "users#newbie"
  get "/users/ranking", to: "users#ranking"
  get "/games/practice", to: "games#practice"
  get "/games/challenge", to: "games#challenge"

  root to: "users#index"
end
