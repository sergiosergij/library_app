Rails.application.routes.draw do 
  root "books#index"

  get "books/author"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :books
end
