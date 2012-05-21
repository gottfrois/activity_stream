ActivityStream::Application.routes.draw do
  root :to => 'activities#index'

  devise_for :users

  resources :activities,  only: [:index, :show, :new, :create, :destroy] do
    resources :comments,  only: [:create, :update, :destroy]
  end

  resources :users
end
