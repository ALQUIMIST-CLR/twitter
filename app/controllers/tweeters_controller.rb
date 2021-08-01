class TweetersController < ApplicationController
  before_action :set_tweeter, only: %i[ show edit update destroy ]
  before_action :set_current_tweet , only: [:likes, :retweet]

  # GET /tweeters or /tweeters.json
  def index
    @tweeters = Tweeter.all
  end

  def retweet
    Tweeter.create(content: @tweeter.content, user_id: current_user.id, rt_ref: @tweeter.id)
     redirect_to root_path
  end

  def likes
    if @tweeter.is_liked?(current_user)
      @tweeter.unlike(current_user)
    else
      @tweeter.like(current_user)
    end
    redirect_to root_path
  end

  # GET /tweeters/1 or /tweeters/1.json
  def show

  end

  # GET /tweeters/new
  def new
    @tweeter = Tweeter.new
  end

  # GET /tweeters/1/edit
  def edit
  end

  # POST /tweeters or /tweeters.json
  def create
    @tweeter = Tweeter.new(tweeter_params)
    @tweeter.user = current_user

    respond_to do |format|
      if @tweeter.save
        #format.html { redirect_to @tweeter, notice: "Tweeter was successfully created." }
        format.html { redirect_to root_path, notice: "Tweeter was successfully created." }
        format.json { render :show, status: :created, location: @tweeter }
      else
        #format.html { render :new, status: :unprocessable_entity }
        format.html { redirect_to root_path, alert: "You must write into content" }

        format.json { render json: @tweeter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweeters/1 or /tweeters/1.json
  def update
    respond_to do |format|
      if @tweeter.update(tweeter_params)
        format.html { redirect_to @tweeter, notice: "Tweeter was successfully updated." }
        format.json { render :show, status: :ok, location: @tweeter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweeter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweeters/1 or /tweeters/1.json
  def destroy
    @tweeter.destroy
    respond_to do |format|
      format.html { redirect_to tweeters_url, notice: "Tweeter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweeter
      @tweeter = Tweeter.find(params[:id])
    end

    def set_current_tweet
      @tweeter = Tweeter.find(params[:tweeter_id])
    end

    # Only allow a list of trusted parameters through.
    def tweeter_params
      params.require(:tweeter).permit(:content)
    end
end
