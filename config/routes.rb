Rails.application.routes.draw do

  get 'posts/trash',                       :to => 'posts#trash'
  resources :posts , except: [:new] do
    member do
      get :soft_delete
    end
    resources :comments, except: [:new] do
      member do
        get :soft_delete
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
