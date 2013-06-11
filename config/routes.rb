Ogyam::Application.routes.draw do
  

  match  '/signup', to: 'users#new'

  root to: 'static_pages#home'

  # match static pages url
  match '/help', to: 'static_pages#help'
  match '/about', to: 'static_pages#about'
  match '/terms', to: 'static_pages#terms'
  match '/blog',  to: 'static_pages#blog'
  match '/press', to: 'static_pages#press'
end
