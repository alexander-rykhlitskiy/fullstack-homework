Rails.application.routes.draw do
  resources :fields, only: [:index]
  resources :crops, only: [:index]
  resources :humus, only: [] do
    get :balance, on: :collection
  end
end
