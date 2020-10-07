Rails.application.routes.draw do
  resources :subscription_plans, only: :index
  resources :subscriptions, only: :create
end
