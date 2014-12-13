module Spree
  module Twitter
    class Tweet < ActiveRecord::Base
      has_and_belongs_to_many :hashtags, 
        join_table: :spree_twitter_hashtags_spree_twitter_tweets,
        association_foreign_key: :spree_twitter_hashtag_id, 
        foreign_key: :spree_twitter_tweet_id 

      after_create :populate_hashtags

      def user
        attrs_hash = eval(attrs)
        OpenStruct.new attrs_hash[:user] 
      end

      def medias
        attrs_hash = eval(attrs)
        attrs_hash[:entities][:media].map{ |x| OpenStruct.new(x) }
      end

      def urls
        attrs_hash = eval(attrs)
        obj = []

        attrs_hash[:entities][:urls].each do |url|
          obj << {
            url: url[:url],
            display: url[:display_url]
          }
        end
        obj
      end

      def markups_and_positions
        attrs_hash = eval(attrs)
        obj = []
        
        attrs_hash[:entities][:hashtags].each do |hashtag|
          obj << {
            val: '</a>',
            pos: hashtag[:indices][1]
          }

          obj << {
            val: self.class.url_hashtag_start(hashtag[:text]),
            pos: hashtag[:indices][0]
          }
        end

        attrs_hash[:entities][:user_mentions].each do |user_mentions|
          obj << {
            val: '</a>',
            pos: user_mentions[:indices][1]
          }

          obj << {
            val: self.class.url_mention_start(user_mentions[:screen_name]),
            pos: user_mentions[:indices][0]
          }
        end

        attrs_hash[:entities][:urls].each do |url|
          obj << {
            val: '</a>',
            pos: url[:indices][1]
          }

          obj << {
            val: self.class.url_start(url[:url]),
            pos: url[:indices][0]
          }
        end

         attrs_hash[:entities][:media].each do |media|
          obj << {
            val: '</a>',
            pos: media[:indices][1]
          }

          obj << {
            val: self.class.url_start(media[:expanded_url]),
            pos: media[:indices][0]
          }
        end

        obj.sort{|x,y| y[:pos] <=> x[:pos]}
      end

      def initialize_twitter_connection
        @twitter_config = Spree::TwitterConfiguration.new
        @client = Twitter::REST::Client.new do |config|
          config.consumer_key        = @twitter_config.consumer_key
          config.consumer_secret     = @twitter_config.consumer_secret
          config.access_token        = @twitter_config.access_token
          config.access_token_secret = @twitter_config.access_token_secret
        end
      end
      
      def self.url_hashtag_start(tag)
        "<a href='http://twitter.com/search?q=%23#{tag}' class='hashtag-link'>"
      end

      def self.url_start(url)
        "<a href='#{url}' class='twitter-url'>"
      end

      def self.url_mention_start(screen_name)
        "<a href='http://twitter.com/#{screen_name}' class='mention-link'>"
      end

      private 

      def populate_hashtags
        attrs_hash = eval(attrs)
        attrs_hash[:entities][:hashtags].each do |hashtag|
          hashtag = Spree::Twitter::Hashtag.find_or_create_by(value: hashtag[:text])
          hashtags << hashtag unless hashtags.include? hashtag
        end
      end
    end
  end
end
