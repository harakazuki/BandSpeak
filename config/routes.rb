Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post 'guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  get '/about' => 'homes#about'
  get '/top' => 'homes#top'
  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :likes
    end
  end
  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
