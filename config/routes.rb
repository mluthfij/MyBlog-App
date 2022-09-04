Rails.application.routes.draw do
  delete '/profiles/:id/destroy_post/:id', to: 'profiles#destroy_post', as: 'destroy_post', :via => :delete
  resources :profiles, only: [:show, :update, :destroy] do
    get 'userlist', on: :member
    get 'allpost', on: :member
  end

  devise_for :users
  resources :posts do
    resources :comments
  end

  root 'pages#home'
end
