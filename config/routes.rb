Rails.application.routes.draw do
  root to: 'groups#index'
  post 'authenticate', to: 'authentication#authenticate'
  resources :groups do
    resources :users
  end

  resources :users do
    resources :tasks
  end
  resources :users do
    resources :tokens, except: %i[new create destroy index update]
  end

  resources :tasks

  post 'user/new-device', to: 'tokens#create'
  post 'user/validate', to: 'tokens#validate'
  get 'user/tokens', to: 'tokens#index'
  get 'user/authenticate', to: 'tokens#show'
  delete 'user/deactivate-device', to: 'tokens#destroy'
  delete 'user', to: 'users#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
