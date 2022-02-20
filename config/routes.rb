Rails.application.routes.draw do
  get 'comments/new'
  post 'comments/create'
  get 'comments/destroy'
  get 'login', to: 'session#login'
  post 'session/create'
  get 'logout', to: 'session#logout'
  resources :posts
  resources :users
  root 'posts#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
