Rails.application.routes.draw do
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root to: "pages#home"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :art_pieces, only: [:new, :create, :edit, :update, :destroy, :index, :show] do
    resources :bookings, only: %i[new create]
  end

  resources :bookings, only: %i[edit update destroy]

end
