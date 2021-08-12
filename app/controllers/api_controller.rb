class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token


  def news
    #render json: Tweeter.last(5)

    tweets = Tweeter.last(5)
    hash = tweets.map do |tweet|
      { 
        id: tweet.id,
        content: tweet.content,
        user_id: tweet.user_id,
        like_count: tweet.likes.count,
        retweet_count: tweet.count_rt,
        retweeted_from: (tweet.rt_ref.nil? ? '' : tweet.rt_ref)
      }
    end
     render json: hash.to_json
  end

  def tweets_by_date
    date1 = Date.parse(params[:date1])
    date2 = Date.parse(params[:date2])

    render json: Tweeter.where(created_at: (date1..date2))
  end

  def create_tweeter
    user = User.authenticate(params[:user][:email], params[:user][:password])
    if user.nil?
      render json: { error: 'Invalid credentials'}
      return
    end


    @tweeter = Tweeter.new(tweeter_params)
    @tweeter.user = user
    if @tweeter.save
     render json: @tweeter, status: :created
    else
      render json: @tweeter.errors, status: :unprocessable_entity
    end
  end

  def tweeter_params
    params.require(:tweeter).permit(:content)
  end

end
