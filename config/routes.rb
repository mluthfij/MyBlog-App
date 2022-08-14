Rails.application.routes.draw do
  # get 'home', to: 'pages#home'
  resources :profiles, only: [:show]

  devise_for :users
  resources :posts do
    resources :comments
  end

  # root 'posts#index'
  root 'pages#home'
end
