Ogyam::Application.routes.draw do
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  match  '/signup', to: 'users#new'
  match  '/signin', to:  'sessions#new'
  match  '/signout',  to:  'sessions#destroy', via: :delete

  root to: 'static_pages#home'

  match '/help', to: 'static_pages#help'
  match '/about', to: 'static_pages#about'
  match '/terms', to: 'static_pages#terms'
  match '/blog',  to: 'static_pages#blog'
  match '/press', to: 'static_pages#press'
end
