Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "home", to: "static_pages#home"
    get "help", to: "static_pages#help"
    get "about", to: "static_pages#about"
    get "contact", to: "static_pages#contact"
    get "signup", to: "users#new"
    post "signup", to: "users#create"
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
    get "publish", to: "entries#new"
    post "publish", to: "entries#create"
    resources :entries, only: [:destroy, :show]
    resources :comments, only: [:create, :destroy, :edit, :update]

    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :account_activations, only: [:edit]
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :microposts, only: [:create, :destroy]
    resources :relationships, only: [:create, :destroy]

    get "change_avatar", to: "change_avatars#new"
    post "change_avatar", to: "change_avatars#change"
  end
end
