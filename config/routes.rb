Rails.application.routes.draw do
  resources :profiles, only: [:show]

  devise_for :users
  resources :posts do
    resources :comments
  end

  root 'posts#index'
end
