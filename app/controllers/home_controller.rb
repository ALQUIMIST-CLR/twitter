class HomeController < ApplicationController
  def index
   # @tweeters = Tweeter.all
    @tweeters = Tweeter.order(created_at: :desc).page params[:page]
    @tweeter = Tweeter.new
  end
end
