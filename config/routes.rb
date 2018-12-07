Rails.application.routes.draw do
  

  resources :beer_lists
  resources :beers, only: [:create, :new, :index]


  resources :bars, only: [:show]

  devise_for :managers, path: 'managers', controllers: {
    sessions: 'managers/sessions', registrations: 'managers/registrations'
  }

  resource :managers do 
    resources :bars, only: [:edit, :new] 
  end 

  resources :bars, only: [:destroy, :create, :update]


  devise_for :users, path:  'users', controllers: {
    sessions: 'users/sessions'
  }

  get 'resultpage/index' , to: "resultpage#index"
  get 'contact', to: "contact#index"
  get 'apropos', to: "apropos#index"
  get 'mentions-legales', to: "mentionlegale#index"
  root 'home#index'

  resources :map, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


