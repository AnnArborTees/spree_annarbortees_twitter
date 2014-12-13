module Spree
    BaseHelper.class_eval do 
    def format_tweet(tweet)
      text = tweet.text
      # tweet.urls.each do |url|
      #   text.gsub!(url[:url], url[:display])
      # end
      # puts "Tweet is now |#{text}|"


      tweet.markups_and_positions.each do |item|
        text.insert(item[:pos], item[:val])
      end

      tweet.urls.each do |url|
        text.gsub!(url[:url], url[:display])
      end
      puts "Tweet is now |#{text}|"

      text
    end
  end
end