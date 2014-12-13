require 'spec_helper'

describe Spree::Twitter::Tweet do
  context '#user' do
    let(:tweet) { create(:tweet_with_media) }
    it 'parses attrs and returns the user information as an openstruct' do
      expect(tweet.user.name).to eq("Ann Arbor T-Shirt Co")
      expect(tweet.user.screen_name).to eq("annarbortees")
      expect(tweet.user.url).to eq("http://t.co/r6FpgHd5XO")
      expect(tweet.user.profile_image_url).to eq("http://pbs.twimg.com/profile_images/732739000/new_logo_medium_normal.gif")
    end
  end

  context '#populate_hashtags' do
    let(:tweet) { create(:tweet_with_hashtags) }
    it 'parses the hashtags, creates them, and assigns them to the tweet' do
      expect(tweet.hashtags.map{|x| x.value } - ['CyberMonday', 'JMOMS']).to be_empty  
    end
  end

  context '#media' do
    let(:tweet) { create(:tweet_with_media) }
    it 'parses the media into an array of open_structs' do
      expect(tweet.medias.size).to eq(1)
      expect(tweet.medias.first.media_url).to eq('http://pbs.twimg.com/media/B4bKjnHCYAAmvFM.png')
      expect(tweet.medias.first.sizes[:large]).to_not be_nil    
    end
  end

  context '#markups_and_positions' do 
    let(:tweet) { create(:tweet_with_hashtags) }
    it 'creates an array of where markup is going to need to go' do
      expect(tweet.markups_and_positions.first).to eq({val: '</a>', pos: 1 })
      expect(tweet.markups_and_positions.last).to eq({val: "<a href='http://twitter.com/search?q=%23CyberMonday' class='hashtag-link'>", pos: 0})
      expect(tweet.markups_and_positions).to include({val: "<a href='http://twitter.com/annarbortees' class='mention-link'>", pos: 37 })
      expect(tweet.markups_and_positions).to include({val: "<a href='http://t.co/NnrEauRWgc' class='twitter-url'>", pos: 117 })
    end
  end  
end
