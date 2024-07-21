Rails.application.routes.draw do
  devise_for :users
  get '/about' => 'homes#about'
  get '/top' => 'homes#top'
  resources :posts do
    resources :comments, only: [:create]
    collection do
      get 'search'
    end
  end
  resources :users
  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
