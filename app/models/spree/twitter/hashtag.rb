module Spree
  module Twitter
    class Hashtag < ActiveRecord::Base
      has_and_belongs_to_many :tweets, 
        join_table: :spree_twitter_hashtags_spree_twitter_tweets,
        foreign_key: :spree_twitter_hashtag_id, 
        association_foreign_key: :spree_twitter_tweet_id 
        
      validates_presence_of :value

    end
  end
end