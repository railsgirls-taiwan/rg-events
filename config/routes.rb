Rails.application.routes.draw do
  root 'events#index'
  devise_for :users

  resources :events, only: [:index, :show] do
    resources :attendees, only: [:new, :create]
  end

  resources :attendees, only: [:show, :index, :new]
  namespace :admin do
    root to: :index
    resources :users
    resources :events do
      resources :attendees
    end
  end
end
