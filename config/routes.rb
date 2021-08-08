Rails.application.routes.draw do
 

  ActiveAdmin.routes(self)
  resources :tweeters do
     post 'likes', to: 'tweeters#likes'
     post 'retweet', to: 'tweeters#retweet'
  end

  devise_for :users
  get 'home/index'
  get 'all_tweets', to: 'home#all_tweets', as: 'all_tweets'

  post 'follow/:friend_id', to: 'users#follow', as: 'users_follow'

  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
