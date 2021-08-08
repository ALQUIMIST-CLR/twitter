class HomeController < ApplicationController
  def index
    if signed_in? 
      @tweeters = Tweeter.tweeters_for_me(current_user).where("content LIKE ?", "%#{params[:search]}%").order(created_at: :desc).page params[:page]
    else
      @tweeters = Tweeter.where("content LIKE ?", "%#{params[:search]}%").order(created_at: :desc).page params[:page]
    end

     @tweeter = Tweeter.new
  end

  def all_tweets
    @tweeters = Tweeter.order(created_at: :desc).page params[:page]
    @tweeter = Tweeter.new

    render "index"
  end

end
