# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


Rails.application.routes.draw do
  devise_for :users

  namespace :v1, defaults: { format: :json } do
    mount_devise_token_auth_for 'User',
                                at: 'auth',
                                skip: [:omniauth_callbacks]

    resource :sessions, only: [:create, :destroy]
    resources :users, only: [:create]
    resources :notes
  end

end
