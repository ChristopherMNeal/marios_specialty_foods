Rails.application.routes.draw do
  devise_for :users
  root to: 'welcome#index'
  resources :products do
    resources :reviews
  end
  resources :users, only:[:index]
end