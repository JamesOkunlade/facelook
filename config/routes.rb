Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users

  get 'me', to: 'users#me'
  resources :users, only: [:index, :show]
  resources :posts
end
