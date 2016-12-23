Rails.application.routes.draw do
  resources :games

  root 'games#index'

  get 'signup' => 'users#new'
  resources :users

end
