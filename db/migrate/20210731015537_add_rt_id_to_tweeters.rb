class AddRtIdToTweeters < ActiveRecord::Migration[6.1]
  def change
    add_column :tweeters, :rt_ref, :integer
  end
end
