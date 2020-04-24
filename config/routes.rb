Rails.application.routes.draw do
  get '/search' => 'search#search'
  get 'relationships/create'
  get 'relationships/destroy'
  get 'book_comments/create'
  get 'book_comments/destroy'
  #get 'favorites/create'
  #get 'favorites/destroy'
  devise_scope :user do
    get "users/sign_in" => "users/sessions#new"
    post "users/sign_in" => "users/sessions#create"
    delete "users/sign_out" => "users/sessions#destroy"
    get "users/sign_up" => "users/registrations#new"  
    post "users" => "users/registrations#create"
    get "users/confirmation/new" => "users/confirmations#new"
    post "users/confirmation" => "users/confirmations#create"
    get "users/confirmation" => "users/confirmations#show"
  end
  devise_for :users, skip: :all
  #if Rails.env.development?
    #mount LetterOpenerWeb::Engine, at: "/letter_opener"
  #end
  
  root 'homes#top'
  get "users/:id" => "users#show", as: "users_show"
  get "users/" => "users#index" , as: "users_index"
  get "users/:id/edit" => "users#edit", as: "users_edit"
  patch "users/:id" => "users#update", as: "users_update"

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  get 'home/about' => 'homes#about'
end

