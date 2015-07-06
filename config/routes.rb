Rails.application.routes.draw do

  root 'dashboard#index'

  scope '/', defaults: { format: :html }, constraints: { format: :html } do
    resources :users
    resources :posts do |p|
      member do
        put 'approve' => 'posts#approve_post'
        put 'deny' => 'posts#deny_post'
      end
    end

    get 'help' => 'dashboard#help'
    get 'signup' => 'users#new'
    get 'approve' => 'posts#approve'
    post 'signup' => 'user#signup'
    get 'login' => 'login#index'
    post 'login' => 'login#verify'
    delete 'login' => 'login#logout'
  end


  scope :api, defaults: { format: :json }, constraints: { format: :json } do
    scope :v1 do
      resources :users, except: [:new, :edit]
      resources :posts, except: [:new, :edit] do |p|
        member do
          get 'comments' => 'comments#post_comments'
          post 'comments' => 'comments#create'
        end
      end
    end
  end

end
