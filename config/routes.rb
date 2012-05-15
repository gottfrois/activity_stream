ActivityStream::Application.routes.draw do
  root :to => 'NewsFeed::activities#index'

  namespace :news_feed do
    resources :activities, only: [:index, :show, :new, :create, :destroy], :controller => :activities do
      resources :comments, only: [:create, :update, :destroy], :controller => :comments
    end
  end

  resources :users, only: :show
end
