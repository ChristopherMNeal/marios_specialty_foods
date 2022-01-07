Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :products do
    resources :reviews
  end
end