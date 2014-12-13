require 'spec_helper'

describe Spree::BaseHelper do
  context '#format_tweet' do 
    let(:tweet) {create(:tweet_with_media)}
    it 'formats a tweet according to the entity data' do
      expect(format_tweet(tweet)).to eq("Cute and Funny Onesies, Baby Tees, and Bibs make perfect Christmas Gifts! Get Yours Here! <a href='bit.ly/aatcbabytees' class='twitter-url'>bit.ly/aatcbabytees</a> <a href='http://twitter.com/annarbortees/status/542343519009275904/photo/1' class='twitter-url'>http://t.co/gjdK05Ybjp</a>")
    end
  end 
end
