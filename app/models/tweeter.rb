class Tweeter < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :liking_users, :through => :likes, :source => :user

  validates :content, :presence => true

  paginates_per 3

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
