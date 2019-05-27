Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users

  get 'user/friends/:id', to: 'users#friends', as: "user_friends"


  post 'friend_requests/accept/:id', to: 'friend_requests#update', as: 'friend_request_accept'
  post 'friend_requests/decline/:id', to: 'friend_requests#decline', as: 'friend_request_decline'

  delete 'friendship/:user_id', to: 'friendships#destroy', as: 'friendship'

  get "post_comments/:post_id/:comments_page", to: "comments#post_comments", as: "post_comments"
  resources :posts
  resources :comments, only: [:create, :destroy]
  resources :users, only: [:index, :show]
  resources :likes, only: [:create, :destroy]
  resources :friend_requests, only: [:index, :create, :update, :destroy]
end
