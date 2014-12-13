require 'spec_helper'

describe Spree::Product do
  context '#tweets' do
    let!(:tweet) { create(:tweet_with_hashtags) }
    let(:product) { create(:base_product, hashtag: 'CyberMonday')}
    it 'parses attrs and returns the user information as an openstruct' do
      expect(product.hashtags).to_not be_empty
    end
  end
end
