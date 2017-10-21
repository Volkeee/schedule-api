Rails.application.routes.draw do
  post 'authenticate', to: 'authentication#authenticate'
  resources :groups do
    resources :users
  end

  resources :users do
    resources :tasks
  end
  resources :users do
    resources :tokens
  end

  resources :tasks

  post 'user/new-device', to: 'tokens#create'
  post 'user/deactivate-device', to: 'tokens#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
