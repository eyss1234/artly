Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root to: "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :art_pieces, only: [:index, :show]

  resources :users do
    resources :art_pieces, only: %i[new create edit update destroy]
    resources :bookings, only: %i[new create edit update destroy]
  end

end
