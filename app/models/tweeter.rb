#include ActionView::Helpers::UrlHelper

class Tweeter < ApplicationRecord
 before_save :add_hashtags

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liking_users, :through => :likes, :source => :user

  validates :content, :presence => true

  paginates_per 10

  scope :tweeters_for_me, ->(user) { where(user_id: user.arr_friends_id_and_me)}

  def add_hashtags
    new_content = ""
    self.content.split(" ").each do |word| 
      if word.start_with?("#")
       word_clean = word.gsub("#", " ")
        #new_content += link_to(word, Rails.application.routes.url_helpers.root_path+"?search=" +word_clean) + " "
         new_content += '<a href="/?search='+word_clean+'">'+word+'</a> '
      else
        new_content += word+ " "
      end
    end
    self.content = new_content
  end
  

  def like_icon(user)
    if self.is_liked?(user)
    'heart'
    else
      'heart-broken'
    end
  end

  def retweet_color
    self.count_rt > 0 ? 'primary' : 'white'
  end

  def is_liked?(user)
    self.liking_users.include?(user)
  end

  def like(user)
    Like.create(user: user, tweeter: self)
  end

  def unlike(user)
    Like.where(user: user, tweeter: self).destroy_all
  end

  def count_rt
    Tweeter.where(rt_ref: self.id).count
  end

  def is_retweet?
    self.rt_ref.present?
  end

  def tweet_ref
    Tweeter.find(self.rt_ref)
  end




end
