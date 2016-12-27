Rails.application.routes.draw do
  resources :accounts do
    resources :transactions
  end
  devise_for :users
  root 'accounts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
