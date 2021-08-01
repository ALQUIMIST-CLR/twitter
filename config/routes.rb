Rails.application.routes.draw do
  resources :tweeters do
     post 'likes', to: 'tweeters#likes'
     post 'retweet', to: 'tweeters#retweet'
  end

  devise_for :users
  get 'home/index'

  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
