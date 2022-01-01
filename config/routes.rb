Rails.application.routes.draw do
  get 'book_comments/create'
  get 'book_comments/destroy'

  root 'homes#top'
  get 'home/about' => 'homes#about'

  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships,only: [:create,:destroy]
    get :followers,on: :member
    get :followed,on: :member
  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]

  end


end