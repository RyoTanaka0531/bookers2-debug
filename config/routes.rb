Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users
  root 'homes#top'
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
  resources :favorites, only: [:create, :destroy]
  get 'home/about' => 'homes#about'
end

