Rails.application.routes.draw do
  devise_for :users
  get '/about' => 'homes#about'
  get 'homes/top' => 'homes#top'
  resources :posts
  get 'users', to: 'users#index', as: 'users'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
