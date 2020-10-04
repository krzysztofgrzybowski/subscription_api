Rails.application.routes.draw do
  resources :subscription_plans, only: :index
end
