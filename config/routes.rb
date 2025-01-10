Rails.application.routes.draw do
  root 'user_sessions#new'
  get :sign_up, to: 'users#new'
  post :sign_up, to: 'users#create'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get 'profiles/:id', to: 'profiles#show', as: 'view_profile'
  resource :profile, only: [:edit, :update] do
    resource :relationships, only: [:create, :destroy]
    member do
      get :follows, :followers
    end
  end

  resources :posts do
    resources :comments, only: %i[create destroy]
    get 'likes', on: :collection
    resource :like, only: %i[create destroy]
    get 'bookmarks', on: :collection
    resource :bookmark, only: %i[create destroy]
  end
end
