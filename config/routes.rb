Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'

  namespace :admin do
    resources :products
  end

  resources :products, only: %i[index show] do
    resources :orders, only: %i[new create]
  end

  resources :orders, only: %i[index]

  resources :employees do
    collection do
      get 'search'
    end
  end

  resources :posts, except: %i[show] do
    resources :comments, only: %i[index new create]

    collection do
      resources :comments, only: %i[destroy]
    end

    member do
      get '/like', to: 'posts#like', as: 'like'
      get '/unlike', to: 'posts#unlike', as: 'unlike'
    end
  end
end
