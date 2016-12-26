Rails.application.routes.draw do
  root 'games#index'

  get 'signup' => 'users#new'

  resources :users do
    resources :games do
      resources :comments
    end
  end

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
