Rails.application.routes.draw do
  root 'user_sessions#new'
  get :sign_up, to: 'users#new'
  post :sign_up, to: 'users#create'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
end
