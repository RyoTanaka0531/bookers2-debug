Rails.application.routes.draw do
  get 'book_comments/create'
  get 'book_comments/destroy'
  #get 'favorites/create'
  #get 'favorites/destroy'
  devise_for :users
  root 'homes#top'
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  get 'home/about' => 'homes#about'
end

