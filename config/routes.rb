Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
  resources :dashboards, only: [:index]
  resources :users, only: [:index, :edit, :update, :destroy]
  resources :comments, only: [:index, :edit, :update, :destroy] do
    collection do
      get 'search'
    end
  end
  resources :posts, only: [:index, :edit, :update, :destroy] do
    collection do
      get 'search'
    end
  end
  resources :reports, only: [:index, :update, :destroy]
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
  
  resources :reports, only: [:create]

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :likes
    end
  end
  root 'homes#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
