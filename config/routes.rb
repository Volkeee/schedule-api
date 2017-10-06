Rails.application.routes.draw do
  resources :items
  post 'authenticate', to: 'authentication#authenticate'
  resources :groups do
    resources :users
  end

  resources :users do
    resources :tasks
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
