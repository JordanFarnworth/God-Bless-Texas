Rails.application.routes.draw do

  root 'dashboard#index'

  scope '/', defaults: { format: :html }, constraints: { format: :html } do
    resources :users
    resources :posts

    get 'login' => 'login#index'
    post 'login' => 'login#verify'
    delete 'login' => 'login#logout'
  end

  scope :api, defaults: { format: :json }, constraints: { format: :json } do
    scope :v1 do
      get 'undelete' => 'companies#deleted'
      resources :users, except: [:new, :edit]
      resources :posts, except: [:new, :edit]
    end
  end

end
