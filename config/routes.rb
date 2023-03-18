Rails.application.routes.draw do

  root to: "home#top"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  resources :users, only: [:show, :edit, :update] do
    member do
      get :profile
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
