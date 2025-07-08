Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :internal do
    namespace :manager do
      resources :users, only: [:index, :show, :destroy] do
        put "/inactivate", on: :member, to: "users#inactivate"
      end
    end
  end

  namespace :client do
    resources :users, only: [:show, :update]
  end

  namespace :webhooks do
    namespace :rh do
      resources :users, only: [:create] do
        put "/inactivate", on: :member, to: "users#inactivate"
      end
    end
  end
end
