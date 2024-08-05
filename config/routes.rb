Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
    resources :comments, only: [:destroy]
  end
  
  devise_for :users
  devise_scope :user do
    post 'guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  get '/about' => 'homes#about'
  get '/top' => 'homes#top'
  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
    resources :likes, only: [:index, :create, :destroy]
    collection do
      get 'search'
    end
  end
  resources :users, only: [:index, :likes, :show, :edit, :update] do
    member do
      get :likes
    end
  end
  root 'homes#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
