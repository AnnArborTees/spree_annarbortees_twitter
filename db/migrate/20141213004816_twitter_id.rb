class TwitterId < ActiveRecord::Migration
  def change
    add_column :spree_twitter_tweets, :tweet_id, 'BIGINT UNSIGNED'
    add_index :spree_twitter_tweets, :tweet_id
  end
end
