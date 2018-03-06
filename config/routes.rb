Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :restaurants, only: [ :index, :show ] do
    resources :check_ins, only: [ :new, :create ]
    resources :reviews, only: :create
  end

  get "users/dashboard", to: "users#dashboard", as: "dashboard"

end
