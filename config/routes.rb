Rails.application.routes.draw do 
  root "books#index"

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :books do
    collection do 
     get "author"
    end
    resources :comments
  end
  
end
