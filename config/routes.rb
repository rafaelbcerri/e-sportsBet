Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks",
    registrations: 'users/registrations'
  }
  get '/bets', to: 'bets#index'
end
