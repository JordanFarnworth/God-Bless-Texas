Rails.application.routes.draw do

  root 'dashboard#index'

  scope '/', defaults: { format: :html }, constraints: { format: :html } do
    resources :users
    resources :posts

    get 'signup' => 'users#new'
    post 'signup' => 'user#signup'
    get 'login' => 'login#index'
    post 'login' => 'login#verify'
    delete 'login' => 'login#logout'
  end

  scope :admin, defaults: { format: :html }, constraints: { format: :html } do

  end

  scope :api, defaults: { format: :json }, constraints: { format: :json } do
    scope :v1 do
      resources :users, except: [:new, :edit]
      resources :posts, except: [:new, :edit]
    end
  end

end
